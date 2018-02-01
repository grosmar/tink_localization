package tink.localization;

/**
 * ...
 * @author duke
 */
@:autoBuild(tink.localization.LocalizationMacro.build())
interface Localization
{
    //var langMap:Map<String, thx.tpl.Template> = new Map();
    //var langMap:Map<String, Dynamic->String> = new Map();

    function set(key:String, value:String):Void;
    /*{
        this.langMap.set(key, new thx.tpl.Template(value));
    }*/

    /*function noParamTemplate(template:String)
    {
        return function() return template;
    }

    function haxeTemplate(template:String)
    {
        return new thx.tpl.Template(template).execute;
    }*/


}

/*class Localization
{
    //var langMap:Map<String, thx.tpl.Template> = new Map();
    var langMap:Map<String, Dynamic->String> = new Map();

    public function set(key:String, value:String)
    {
        this.langMap.set(key, new thx.tpl.Template(value));
    }



}

*/