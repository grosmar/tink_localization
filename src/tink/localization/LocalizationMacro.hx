package tink.localization;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.Field;

class LocalizationMacro
{
    macro static public
    function fromBaseClass():Array<Field>
    {
        var langMapExpr:Array<Expr> = [];

        var fields = Context.getBuildFields();


        for ( field in fields)
        {
            if ( field.name == "new" )
                continue;

            switch (field.kind)
            {
                case FFun(f):
                    switch(f.expr.expr)
                    {
                        case EConst(CString(s)) | EReturn({ expr : EConst(CString(s))}):
                        //case EConst(CString(s)) | EReturn({ expr : EConst(CString(s))}):
                            var fieldName = field.name;
                            var argMapExpr:Array<Expr> = [];

                            for ( arg in f.args )
                            {
                                argMapExpr.push( macro $v{arg.name} => $i{arg.name} );
                            }

                            if ( f.args.length == 0 )
                                langMapExpr.push( macro $v{fieldName} => function(_) return $v{s} );
                            else
                                langMapExpr.push( macro $v{fieldName} => new thx.tpl.Template( $v{s} ).execute );


                            var f =
                            {
                                args: f.args,
                                ret: f.ret,
                                expr: f.args.length == 0
                                    ? macro {
                                        return langMap[$v{fieldName}](null);
                                    }
                                    : macro {
                                        var argMap:Map<String,Dynamic> = $a{argMapExpr};
                                        return langMap[$v{fieldName}](argMap);
                                    }
                            };

                            field.kind = FFun(f);
                            field.access = [Access.APublic, Access.AInline];

                        case v:
                            //TODO: manange block and return expr
                            throw "Only string body allowed: " + field.name + "\n"+v;
                    }


                default:
                    //trace(field);
            }
        }

        var mapField:Field =
        {
            name:  "langMap",
            access: [Access.APrivate],
            kind: FieldType.FVar(macro : Map<String, Dynamic->String>, macro $a{langMapExpr}),
            pos: Context.currentPos(),
            meta: null,
            doc: null
        };

        fields.push(mapField);

        //this.langMap.set(key, new thx.tpl.Template(value));

        var f =
        {
            args: [{name: "key",
                    type: macro :String
                    },
                    {name: "value",
                     type: macro :String
                    }],
            ret: macro :Void,
            expr: macro {
                this.langMap.set(key, new thx.tpl.Template(value).execute);
            }
        };

        var setField:Field =
        {
            name:  "set",
            access: [Access.APublic],
            kind: FieldType.FFun(f),
            pos: Context.currentPos(),
            meta: null,
            doc: null
        };

        fields.push(setField);

        return fields;
    }
}