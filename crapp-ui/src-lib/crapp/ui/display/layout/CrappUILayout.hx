package crapp.ui.display.layout;

import tricks.layout.LayoutAlignment;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutSize;
import priori.event.PriEvent;
import tricks.layout.Layout;
import tricks.layout.LayoutElement;

/**
   A classe CrappUILayout tem como finalidade organizar visualmente os elementos filhos em um container, definindo a distribuição, o alinhamento e o espaçamento nos eixos horizontal e vertical.
   
   #### Responsabilidades:
   - Gerenciar a disposição dos componentes visuais, aplicando configurações de distribuição, alinhamento e gaps para ajustar e redimensionar os elementos internos de forma responsiva.
   - Atualizar o layout quando eventos de redimensionamento dos componentes internos forem detectados.
   
   #### Eventos Emitidos:
   - PriEvent.RESIZE: emitido pelos elementos internos para indicar mudanças de tamanho, acionando a atualização do layout.
**/
class CrappUILayout extends CrappUIDisplay {
    
    private var invalid:Bool;

    /**
       Propriedade que define a distribuição horizontal dos elementos do layout.
       
       @default LayoutDistribution.NONE
    **/
    @:isVar public var hLayoutDistribution(default, set):LayoutDistribution = LayoutDistribution.NONE;

    /**
       Propriedade que define a distribuição vertical dos elementos do layout.
       
       @default LayoutDistribution.NONE
    **/
    @:isVar public var vLayoutDistribution(default, set):LayoutDistribution = LayoutDistribution.NONE;

    /**
       Propriedade que define o alinhamento horizontal dos elementos do layout.
       
       @default LayoutAlignment.NONE
    **/
    @:isVar public var hLayoutAlignment(default, set):LayoutAlignment = LayoutAlignment.NONE;

    /**
       Propriedade que define o alinhamento vertical dos elementos do layout.
       
       @default LayoutAlignment.NONE
    **/
    @:isVar public var vLayoutAlignment(default, set):LayoutAlignment = LayoutAlignment.NONE;

    /**
       Propriedade que define o espaçamento horizontal entre os elementos do layout.
       
       @default 0.0
    **/
    @:isVar public var hLayoutGap(default, set):Float = 0.0;

    /**
       Propriedade que define o espaçamento vertical entre os elementos do layout.
       
       @default 0.0
    **/
    @:isVar public var vLayoutGap(default, set):Float = 0.0;
    
    public function new() {
        this.invalid = false;
        super();
    }
    
    override function get_layout():LayoutElement<CrappUIDisplay> {
        var layout = super.get_layout();
        
        layout.isContainer = true;

        layout.horizontal.distribution = this.hLayoutDistribution;
        layout.horizontal.alignment = this.hLayoutAlignment;
        layout.horizontal.gap = this.hLayoutGap;

        layout.vertical.distribution = this.vLayoutDistribution;
        layout.vertical.alignment = this.vLayoutAlignment;
        layout.vertical.gap = this.vLayoutGap;

        for (i in 0 ... this.numChildren) {
            var child = this.getChild(i);
            
            if (!child.visible) continue;
            else if (!Std.isOfType(child, CrappUIDisplay)) continue;

            layout.children.push((cast(child, CrappUIDisplay)).layout);
        }
        
        if (layout.children.length == 0) {
            if (layout.horizontal.size == LayoutSize.FIT) {
                layout.horizontal.size = LayoutSize.FIXED;
                layout.width = 0;
            }
            if (layout.vertical.size == LayoutSize.FIT) {
                layout.vertical.size = LayoutSize.FIXED;
                layout.height = 0;
            }
        }
        
        return layout;
    }

    override function set_layout(value:LayoutElement<CrappUIDisplay>):LayoutElement<CrappUIDisplay> {
        this.invalid = true;

        var layout = super.set_layout(value);

        if (layout.children != null) for (i in 0 ... layout.children.length) {
            this.layout.children[i].ref.layout = layout.children[i];
        }
        
        this.invalid = false;
        return layout;
    }
    
    override function paint() {
        if (this.invalid) return;

        var layoutElement:LayoutElement<CrappUIDisplay> = this.layout;
        var layout:Layout = new Layout();
        layout.organize(layoutElement);

        this.layout = layoutElement;
    }

    override function addChildList(childList:Array<Dynamic>):Void {
        for (child in childList) if (child != null) child.addEventListener(PriEvent.RESIZE, this.onChildResize);
        super.addChildList(childList);
    }

    override function removeChildList(childList:Array<Dynamic>):Void {
        for (child in childList) if (child != null) child.removeEventListener(PriEvent.RESIZE, this.onChildResize);
        super.removeChildList(childList);
    }

    private function onChildResize(event:PriEvent):Void {
        if (this.invalid) return;

        this.updateDisplay();
    }

    function set_hLayoutDistribution(value:LayoutDistribution):LayoutDistribution {
        this.hLayoutDistribution = value;
        this.updateDisplay();
        return value;
    }

    function set_vLayoutDistribution(value:LayoutDistribution):LayoutDistribution {
        this.vLayoutDistribution = value;
        this.updateDisplay();
        return value;
    }

    function set_hLayoutAlignment(value:LayoutAlignment):LayoutAlignment {
        this.hLayoutAlignment = value;
        this.updateDisplay();
        return value;
    }

    function set_vLayoutAlignment(value:LayoutAlignment):LayoutAlignment {
        this.vLayoutAlignment = value;
        this.updateDisplay();
        return value;
    }

    function set_hLayoutGap(value:Float):Float {
        this.hLayoutGap = value;
        this.updateDisplay();
        return value;
    }

    function set_vLayoutGap(value:Float):Float {
        this.vLayoutGap = value;
        this.updateDisplay();
        return value;
    }
}