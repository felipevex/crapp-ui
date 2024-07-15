package crapp.ui.event;

enum abstract CrappUIEventType(String) from String to String {
    
    var STYLE_CHANGE = 'CRAPP:UI:STYLE_CHANGE';
    var UPDATE_DISPLAY = 'PUI:UPDATE_DISPLAY';

}