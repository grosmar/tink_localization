package tink.localization;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.Field;

class LocalizationMacro
{
    macro static public
    function fromBaseClass():Array<Field>
    {
        var langMap:Array<Expr> = [];

        var fields = Context.getBuildFields();


        for ( field in fields)
        {
            switch (field.kind)
            {
                case FFun(f):
                    switch(f.expr.expr)
                    {
                        case EConst(c):
                            switch(c)
                            {
                                case CString(s):
                                    var fieldName = field.name;
                                    langMap.push(macro $v{fieldName} => $v{s});
                                    var f =
                                    {
                                        args: f.args,
                                        ret: f.ret,
                                        expr: macro {
                                            return new haxe.Template( langMap[$v{fieldName}] ).execute({name:name});
                                        }
                                    };

                                    field.kind = FFun(f);
                                    field.access = [Access.APublic, Access.AStatic, Access.AInline];

                                default:
                                    throw "Invalid content";
                            }

                        default:
                            //TODO: maange block and return
                            throw "Only string body allowed";
                    }


                default:
                    trace(field);
            }
        }

        var mapField:Field =
        {
            name:  "langMap",
            access: [Access.APublic, Access.AStatic],
            kind: FieldType.FVar(macro : Map<String, String>, macro $a{langMap}),
            pos: Context.currentPos(),
            meta: null,
            doc: null
        };

        fields.push(mapField);

        return fields;
    }
}