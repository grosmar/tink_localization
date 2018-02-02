package tink.localization;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.Field;

class LocalizationMacro
{
    macro static public function build():Array<Field>
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
                        case   EConst(CString(s))
                             | EReturn({ expr : EConst(CString(s))}):
                            var fieldName = field.name;
                            var argMapExpr:Array<Expr> = [];

                            for ( arg in f.args )
                            {
                                argMapExpr.push( macro $v{arg.name} => $i{arg.name} );
                            }

                            if ( f.args.length == 0 )
                                langMapExpr.push( macro $v{fieldName} => {type: "smpl", tpl: function(_) return $v{s}} );
                            else
                                langMapExpr.push( macro $v{fieldName} => {type: "thx", tpl: new thx.tpl.Template( $v{s} ).execute} );


                            var f =
                            {
                                args: f.args,
                                ret: f.ret,
                                expr: f.args.length == 0
                                    ? macro {
                                        return langMap[$v{fieldName}].tpl(null);
                                    }
                                    : macro {
                                        var argMap:Map<String,Dynamic> = $a{argMapExpr};
                                        return langMap[$v{fieldName}].tpl(argMap);
                                    }
                            };

                            field.kind = FFun(f);
                            field.access = [Access.APublic, Access.AInline];

                        case v:
                            trace( f.expr );
                            throw Context.error("Only string body allowed in function '" + field.name + "'", f.expr.pos ) ;
                    }


                default:
                    //trace(field);
            }
        }

        fields.push(buildMapField(langMapExpr));
        fields.push(buildSetField());

        return fields;
    }
    static function buildMapField(langMapExpr)
    {
        return
        {
            name:  "langMap",
            access: [Access.APrivate],
            kind: FieldType.FVar(macro : Map<String, {type:String, tpl:Dynamic->String}>, macro $a{langMapExpr}),
            pos: Context.currentPos(),
            meta: null,
            doc: null
        };

    }

    static function buildSetField()
    {
        var f =
        {
            args: [{ name: "key",
                type: macro :String
            },
            { name: "value",
                type: macro :String
            }],
            ret: macro :Void,
            expr: macro {

                switch( this.langMap.get(key).type )
                {
                    case "thx":  this.langMap.set(key, {type:"thx", tpl: new thx.tpl.Template(value).execute});
                    case "smpl": this.langMap.set(key, {type:"smpl", tpl: function(_) return value });
                    default:
                    trace("Invalid field to set: ", key, value);
                }

            }
        };


        return
        {
            name:  "set",
            access: [Access.APublic],
            kind: FieldType.FFun(f),
            pos: Context.currentPos(),
            meta: null,
            doc: null
        };

    }
}