package crapp.ui.display.input;

import haxe.io.BytesData;
import haxe.io.Bytes;
import priori.event.PriEvent;
import priori.event.PriDragEvent;
import priori.view.form.PriFormFileDrop;
import js.html.Console;

/**
    A classe CrappUIFileDropInput tem como finalidade gerenciar um componente de interface que possibilita a inserção de arquivos através do mecanismo de arrastar e soltar.
    #### Responsabilidades:
    - Gerenciar eventos de arrastar, soltar e detecção de arquivos.
    - Atualizar a interface gráfica conforme a interação do usuário.
    #### Eventos Emitidos:
    - PriDragEvent.DRAG_ENTER: Evento disparado quando um arquivo é arrastado para a área de drop.
    - PriDragEvent.DRAG_LEAVE: Evento disparado quando o arquivo arrastado sai da área de drop.
    - PriEvent.CHANGE: Evento disparado quando um arquivo é solto na área ou o usuário seleciona um arquivo.
**/
@:access(priori.view.form.PriFormFileDrop)
class CrappUIFileDropInput extends CrappUIInput<String> {
    
    /**
        Variável que armazena os tipos de arquivos aceitos.
        @default null
    **/
    public var acceptFiles(default, set):Array<String>;

    private var input:PriFormFileDrop;

    override function setup() {
        super.setup();

        this.createInput();
    }

    /**
        Método que reinicia o componente.
    **/
    public function clear():Void {
        this.killInput();
        this.createInput();
    }

    private function createInput():Void {
        this.input = new PriFormFileDrop();
        this.input.pointer = true;
        this.input.addEventListener(PriDragEvent.DRAG_ENTER, this.onFieldDragEnter);
        this.input.addEventListener(PriDragEvent.DRAG_LEAVE, this.onFieldDragLeave);
        this.input.addEventListener(PriEvent.CHANGE, this.onFieldDrop);

        this.updateAcceptFiles();

        this.addChild(this.input);
    }

    private function killInput():Void {
        if (this.input == null) return;

        this.input.removeFromParent();
        this.input.kill();

        this.input = null;
    }

    override function paint() {
        super.paint();

        if (this.input == null) return;

        var space:Int = 40;

        this.input.x = - space;
        this.input.y = - space;
        this.input.width = this.width + space * 2;
        this.input.height = this.height + space * 2;

    }

    /**
        Método que lê o arquivo selecionado e retorna seus dados em forma de Bytes através do callback fornecido.
        @param onRead Função callback que recebe os dados lidos como Bytes.
    **/
    public function readFileBytes(onRead:(data:Bytes)->Void):Void {
        this.input.getDataAsBytes(0, (data:BytesData) -> {
            onRead(Bytes.ofData(data));
        });
    }

    override function get_value():String {
        var files:Array<String> = this.input.getFiles();

        if (files.length > 0) return files[0];
        else return null;
    }

    override function set_value(value:String):String {
        Console.warn("Set value to a CrappUIFileInput has no effect.");
        return value;
    }

    private function onFieldDragEnter(e:PriDragEvent):Void {
        this.dispatchEvent(new PriDragEvent(e.type));
        if (this.actions.onDragEnter != null) this.actions.onDragEnter();
    }

    private function onFieldDragLeave(e:PriDragEvent):Void {
        this.dispatchEvent(new PriDragEvent(e.type));
        if (this.actions.onDragLeave != null) this.actions.onDragLeave();
    }

    private function onFieldDrop(e:PriEvent):Void {
        this.dispatchEvent(new PriEvent(e.type));
        if (this.actions.onChange != null) this.actions.onChange();
    }

    private function set_acceptFiles(value:Array<String>):Array<String> {
        this.acceptFiles = value;
        this.updateAcceptFiles();
        return value;
        
    }

    private function updateAcceptFiles():Void {
        var acceptValue:String = (this.acceptFiles == null )
            ? null 
            : this.acceptFiles.join(',');

        this.input._baseElement.attr('accept', acceptValue);
    }

}
