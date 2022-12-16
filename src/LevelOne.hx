import ceramic.Visual;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Scene;
import ceramic.Color;
import ceramic.Quad;
import ceramic.Text;
import Player;

using ceramic.VisualTransition;

class LevelOne extends Scene {
    var plr: Player;
    var block: Visual;
    
    override function create() {
        app.arcade.world.gravityY = -90;

        block = initBlock("Hellope, worl!");
        add(block);
        
        plr = new Player();
        plr.depth = 1;
        plr.anchor(0.5, 0.5);
        plr.pos(width/2, height - 65);
        add(plr);

        var hint = initHint("I hate", "mice");
        add(hint);

        app.arcade.onUpdate(this, updatePhysics);
    }
    function updatePhysics(d: Float) {
        plr.updatePhysics([block]); //!get collisions working
    }

    function initBlock(t:String): Visual {
                //begin block and children definition//
        block = new Visual();
        block.depth = 0; //lets player be shown in front
        block.pos(width/2, height/2);

        var q = new Quad();
        q.size(200, 200);
        q.color = Color.WHITE;
        q.anchor(0.5, 0.5);
        q.initArcadePhysics();
        q.body.immovable = true;
        q.body.allowGravity = false;
        block.add(q);

        var txt = new Text();
        txt.align = CENTER;
        txt.color = Color.BLACK;
        txt.content = t;
        txt.anchor(0.5, 0.5);
        txt.pointSize = 30;
        txt.color = Color.CRIMSON;
        txt.clip = q; //makes text clip if out of q bounds
        block.add(txt);
        //end//


                //animates the block to a larger size when mouse enters
        q.onPointerOver(this, info -> {
            q.transition(QUAD_EASE_IN_OUT, 0.3, cb -> {
                cb.size(300, 300);
                cb.color = Color.CYAN;
            });
            txt.transition(QUAD_EASE_OUT, 0.35, cb -> {cb.color = Color.HOTPINK;});
            txt.tween(QUAD_EASE_OUT, 0.3, 30, 60, (v, t) -> {txt.pointSize = v;});
        });

        //animates the block back to normal size when mouse leaves
        q.onPointerOut(this, info -> {
            q.transition(QUAD_EASE_IN_OUT, 0.2, cb -> {
                cb.size(200, 200);
                cb.color = Color.WHITE;
            });
            txt.transition(QUAD_EASE_OUT, 0.35, cb -> {cb.color = Color.CRIMSON;});
            txt.tween(QUAD_EASE_OUT, 0.3, 60, 30, (v, t) -> {txt.pointSize = v;});
        });
        return block;
    }
    function initHint(caption:String, hint:String): Visual{
        var cont = new Visual();

        //the rest of the hint
        var caption = new Text();
        caption.align = CENTER;
        caption.content = caption + " ";
        caption.pointSize = 40;
        caption.color = Color.AZURE;
        caption.anchor(1, 0.5);
        caption.pos(width/2, height - 35);
        cont.add(caption);
        //the yellow 'mice' text
        var hint = new Text();
        hint.content = hint + ".";
        hint.pointSize = 50;
        hint.color = Color.YELLOW;
        hint.anchor(0, 0.5);
        hint.pos(width/2 + 3, height - 35);
        cont.add(hint);
        plr.onceDragged(this, () -> {
            hint.visible = false;
            caption.anchor(0.5, 0.5);
            caption.color = Color.HOTPINK;
            caption.content = "That's why.";
        });
        return cont;
    }
}