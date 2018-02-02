package tink.localization;

/**
 * Base interface to implement
 * @author grosmar
 */
@:autoBuild(tink.localization.LocalizationMacro.build())
interface Localization
{
    function set(key:String, value:String):Void;
}