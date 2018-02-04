package;

import tink.localization.Localization;
class Playground
{

    static function main()
    {
        // The example is with singleton but you could use with any composition concept
        Lang.inst = new Lang();
        var lang = Lang.inst;

        // Simple localization without param
        trace(lang.simple());

        // Simple template
        trace(lang.hello("John"));
        trace(lang.happyBirthday("Johnny",13));

        // Overwite param at runtime, for example from loaded language file
        lang.set("hello", "Hola ::name::");
        trace(lang.hello("Paolo"));

        // Complex template content (check Lang class)
        trace(lang.credit(1));
        trace(lang.credit(3));
    }
}


class Lang implements Localization
{
    public static var inst;
    public function new () {}  // private constructor

    public function simple()
        return 'Simple template without param';

    public function hello(name)
        'Hello ::name::';

    public function happyBirthday(name, age)
        'Happy ::age::th birthday ::name::';

    public function credit(amount)
        '::if (amount <= 1):: credit ::else:: credits ::end::';

}
