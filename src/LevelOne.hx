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
    var hint = new Text();
    var caption = new Text();
    override function create() {
        //begin block and children definition//
        var block = new Visual();
        block.depth = 0; //lets player be shown in front
        block.pos(width/2, height/2);
        add(block);

        var q = new Quad();
        q.size(200, 200);
        q.color = Color.WHITE;
        q.anchor(0.5, 0.5);
        block.add(q);

        var txt = new Text();
        txt.align = CENTER;
        txt.color = Color.BLACK;
        txt.content = "Hellope, worl!";
        txt.anchor(0.5, 0.5);
        txt.pointSize = 30;
        txt.color = Color.CRIMSON;
        txt.clip = q; //makes text clip if out of q bounds
        block.add(txt);
        //end//

        plr = new Player();
        plr.depth = 1;
        plr.anchor(0.5, 0.5);
        plr.pos(width/2, height - 65);
        add(plr);

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

        //the rest of the hint
        caption = new Text();
        caption.align = CENTER;
        caption.content = "I hate ";
        caption.pointSize = 40;
        caption.color = Color.AZURE;
        caption.anchor(1, 0.5);
        caption.pos(width/2, height - 35);

        //the yellow 'mice' text
        hint = new Text();
        hint.content = "mice.";
        hint.pointSize = 50;
        hint.color = Color.YELLOW;
        hint.anchor(0, 0.5);
        hint.pos(width/2 + 3, height - 35);
    }
    override function update(delta: Float) {
        if (plr.dragged) {
            hint.visible = false;
            caption.content = "That's why.";
            caption.anchor(0.5, 0.5);
            caption.color = Color.LIGHTPINK;
        }
    }
}