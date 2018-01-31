package;

import tink.localization.Localization;
class Playground
{

    static function main()
    {
        //trace(Lang.langMap);
        //haxe.Template.
        trace(Lang.hello("francis"));
        trace(Lang.hello("doki"));
        trace(Lang.world("apple",13));

        Lang.langMap.set("hello", "hello cica ::name::");
        trace(Lang.hello("francis"));
    }
}


class Lang extends Localization
{
    public static function hello(name)
        'Hello $name::';

    public static function world(name, age)
        'Happy ${name} day ${age}';
}