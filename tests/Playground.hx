package;

import tink.localization.Localization;
class Playground
{

    static function main()
    {
        //trace(Lang.langMap);
        //haxe.Template.
        var lang = Lang.inst;

        trace(lang.hello("francis"));
        trace(lang.hello("doki"));
        trace(lang.world("apple",13));

       // lang.set("hello", "hello cica ::name::");
        trace(lang.hello("francis"));

        /*lang.simple()
        langMap["simple"]();

        lang.hello("name")

        langMap("hello")template.execute("name");*/
    }
}


class Lang implements Localization
{
    public static var inst(default, null) = new Lang();
    private function new () {}  // private constructor

    public function simple()
        return 'Simplle';

    public function hello(name)
        'Hello $name';

    public function world(name, age)
        'Happy ${name} day ${age}';
}
/*
class Lang extends Localization
{
    public static var inst(default, null) = new Lang();
    private function new () {}  // private constructor

    var langMap:Map<String, thx.tpl.Template> = [
        "hello" => new thx.tpl.Template("hello ${name}}")
    ];

    public function hello(name)
        return langMap["hello"].execute(["name" => name]);

    public function world(name, age)
    'Happy ${name} day ${age}';
}*/