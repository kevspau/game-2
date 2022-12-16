import ceramic.Quad;
import ceramic.Color;
import ceramic.TouchInfo;

using ceramic.VisualTransition;

class Player extends Quad {
    var spx: Float;
    var spy: Float;
    var sqx: Float;
    var sqy: Float;
    @event function dragged();
    public function new() {
        super();
        initArcadePhysics();
        body.collideWorldBounds = true;
        size(25, 25);
        anchor(0.5, 0.5);
        color = Color.RED;
        this.onPointerDown(app.scenes.main, onDrag);
    }
    function onDrag(info:TouchInfo) {
        this.transition(QUAD_EASE_IN, 0.15, (cb) -> {
            cb.size(40, 40);
        });
        spx = screen.pointerX;
        spy = screen.pointerY;
        sqx = x;
        sqy = y;
        screen.onPointerMove(app.scenes.main, changePos);
        this.oncePointerUp(app.scenes.main, (info: TouchInfo) -> {
            screen.offPointerMove(changePos);
            this.transition(QUAD_EASE_IN, 0.15, (cb) -> {
                cb.size(25, 25);
            });
        });
    }
    function changePos(info: TouchInfo) {
        this.pos(sqx + screen.pointerX - spx, sqy + screen.pointerY - spy);
    }
    public function updatePhysics(a:Array<arcade.Collidable>) {
        for (v in a) {
            app.arcade.world.collide(this, v);
        }
    }
}