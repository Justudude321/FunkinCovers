package states.stages.objects;

class FightHUD extends FlxSpriteGroup {
    public var healthHeartsPlayer:Array<FlxSprite> = [];
    public var healthHeartsOpponent:Array<FlxSprite> = [];
    public var dodgeCounter:FlxSprite;
    public var atkDodge:FlxSprite;
    public var spaceDeath:FlxSprite;
    public var dodgeSprite:FlxSprite;
    public var ply:{maxhp:Int, hp:Int};
    public var opp:{maxhp:Int, hp:Float} = {maxhp: 5, hp: 5};
    var isDownScroll:Bool;
    var isMiddleScroll:Bool;

    public function new() {
        super();
        isDownScroll = ClientPrefs.data.downScroll;
        isMiddleScroll = ClientPrefs.data.middleScroll;

        // Player HP based on difficulty
        var diffs = [5, 4, 3]; // Easy, Normal, Hard
        ply = {maxhp: diffs[PlayState.storyDifficulty], hp: diffs[PlayState.storyDifficulty]};

        // Dodge button
        var atkDodge:FlxSprite = new FlxSprite(isMiddleScroll ? 508 : 825, isDownScroll ? 105 : 165);
        atkDodge.frames = Paths.getSparrowAtlas("mouthman/ui/space");
        atkDodge.animation.addByPrefix("bop", "bop", 24, false);
        atkDodge.animation.addByPrefix("pressed", "pressed", 24, false);
        atkDodge.offset.set(7, 10);
        atkDodge.setGraphicSize(Std.int(atkDodge.width * 0.94));
        atkDodge.alpha = 0;
        add(atkDodge);

        // Space death
        var spaceDeath:FlxSprite = new FlxSprite(isMiddleScroll ? 470 : 787, isDownScroll ? 62 : 122);
        spaceDeath.frames = Paths.getSparrowAtlas("mouthman/ui/space_death");
        spaceDeath.animation.addByPrefix("bop", "bop", 24, false);
        spaceDeath.alpha = 0;
        add(spaceDeath);

        // Counter
        dodgeCounter = new FlxSprite(isMiddleScroll ? 616 : 933, isDownScroll ? 505 : 565);
        dodgeCounter.frames = Paths.getSparrowAtlas("alphabet");
        for (i in 0...10)
            dodgeCounter.animation.addByPrefix(Std.string(i),  i + " bold", 32, true);
        dodgeCounter.offset.set(-3, 0);
        dodgeCounter.alpha = 0;
        add(dodgeCounter);

        // Health hearts
        var centerY = FlxG.height / 2;
        for (i in 0...5) {
            var offset = 100 * (i - 2); // Space opponent hearts 100px from center
            var adjust = isDownScroll ? 30 : -30;
            var heartX = isMiddleScroll ? 60 : 20;
            var heart = new FlxSprite(heartX, centerY + offset - adjust);
            heart.frames = Paths.getSparrowAtlas("mouthman/ui/binej_heart");
            heart.animation.addByPrefix("bump", "bump0", 24, false);
            heart.animation.addByPrefix("half", "half", 24, false);
            heart.animation.addByPrefix("explode", "explode", 24, false);
            heart.offset.set(50, 75);
            heart.alpha = 0;
            add(heart);
            healthHeartsOpponent.push(heart);
        }

        for (i in 0...ply.maxhp) {
            var offset = 100 * (i - (ply.maxhp - 1) / 2); // Center player hearts
            var adjust = isDownScroll ? 30 : -30;
            var heartX = isMiddleScroll ? FlxG.width - 130 : FlxG.width - 90;
            var heart = new FlxSprite(heartX, centerY + offset - adjust);
            heart.frames = Paths.getSparrowAtlas("mouthman/ui/bf_heart");
            heart.animation.addByPrefix("appear", "appear", 24, false);
            heart.animation.addByPrefix("bump", "bump", 24, false);
            heart.animation.addByPrefix("explode", "explode", 24, false);
            heart.animation.addByPrefix("empty", "empty", 12, true);
            heart.offset.set(13, 16);
            heart.alpha = 0;
            add(heart);
            healthHeartsPlayer.push(heart);
        }
    }

    public function readyHearts() {
        for (i in 0...5) {
            FlxTween.tween(healthHeartsOpponent[i], {alpha: 1, x: healthHeartsOpponent[i].x + 40}, 0.75, {ease: FlxEase.cubeOut, startDelay: i * 0.1});
            healthHeartsOpponent[i].animation.play("bump");
        }
        for (i in 0...ply.maxhp) {
            FlxTween.tween(healthHeartsPlayer[i], {alpha: 1}, 0.4, {ease: FlxEase.cubeInOut, startDelay: i * 0.1});
            healthHeartsPlayer[i].animation.play("appear");
        }
    }

    public function updateHealthBars(oppHP:Float, plyHP:Int) {
        opp.hp = oppHP;
        ply.hp = plyHP;
        
        for (i in 0...5) {
            var heart = healthHeartsOpponent[i];
            if (heart.animation.curAnim != null && heart.animation.curAnim.name != "explode") {
                heart.animation.play(i < Math.floor(opp.hp) ? "bump" : i < opp.hp ? "half" : "explode");
            }
        }
        for (i in 0...ply.maxhp) {
            var heart = healthHeartsPlayer[i];
            if (heart.animation.curAnim != null && heart.animation.curAnim.name != "explode") {
                heart.animation.play(i < ply.hp ? "bump" : "empty");
            }
        }
    }

    public function startDodge(beats:Int, isFakeout:Bool, isSpit:Bool) {
        dodgeCounter.alpha = 1;
        dodgeCounter.color = isFakeout ? 0xFFAAAA : 0xFFFFFF;
        dodgeCounter.animation.play(Std.string(beats));

        dodgeSprite = (isSpit || ply.hp == 1) ? spaceDeath : atkDodge;
        dodgeSprite.alpha = 1;
        dodgeDance(isSpit);
    }

    public function handleDodgeInput(beatsLeft:Int, isFakeout:Bool, isSpit:Bool) {
        // SpaceDeath doesn't have an animation for that, lol
        dodgeSprite.animation.play("pressed");
    }

    public function dodgeDance(isSpit:Bool) {
        dodgeSprite.animation.play("bop");
    }

    public function hideDodge(isSpit:Bool) {
        FlxTween.tween(dodgeCounter.scale, {x: 0.75, y: 0.75}, 0.25, {ease: FlxEase.backInOut});
        FlxTween.tween(dodgeSprite, {alpha: 0}, 0.6, {ease: FlxEase.circIn});
        FlxTween.tween(dodgeCounter, {alpha: 0}, 0.75, {ease: FlxEase.quartIn});
    }
}