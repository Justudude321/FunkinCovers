package states.stages.objects;

import substates.GameOverSubstate;
import objects.Character;

enum BattleState {
    Idle;
    Attacking(beatsLeft:Int, hasAttacked:Bool, hitQuality:Int, secret:Bool);
    Dodging(beatsLeft:Int, hasDodged:Bool, isFakeout:Bool, attackType:String, spitAttack:Bool);
    AttackSuccess;
    AttackFail;
    DodgeSuccess;
    DodgeFail;
    Fakeout;
    SpitGameOver;
    KnockOut;
}

class BattleSystem extends FlxSpriteGroup {
    public var state:BattleState = Idle;
    public var atkCombo:Int = 0;
    public var canAttack:Bool = false;
    public var canDodge:Bool = false;
    public var hasAttacked:Bool = false;
    public var hasDodged:Bool = false;
    public var isFakeout:Bool = false;
    public var fellForFakeout:Bool = false;
    public var spitAttack:Bool = false;
    public var attackType:String = "punch";
    public var secret:Bool = false;

    public var binejBattle:Character;
    public var bloodBinej:FlxSprite;
    public var hitFX:FlxSprite;
    public var spitFX:FlxSprite;
    public var bfMelted:FlxSprite;
    public var comboText:FlxSprite;
    public var textEarly:FlxSprite;
    public var textFakedOut:FlxSprite;
    public var textFail:FlxSprite;
    public var textGood:FlxSprite;
    public var textPerfect:FlxSprite;
    public var atkBar:FlxSprite;
    public var atkBarHit:FlxSprite;
    public var secretBar:FlxSprite;
    public var secretBarHit:FlxSprite;
    public var atkArrow:FlxSprite;
    public var atkArrowHit:FlxSprite;

    public var onKnockOut:Void->Void;
    public var fightHUD:FightHUD;
    public var window:Map<String, Array<Array<Array<Float>>>> = [
        "def" => [[[-44, 57]], [[-26, 28.5]]],
        "secret" => [[[9, 54], [-46, -6]], [[24, 46], [-39, -25]]]
    ];
    public var botPlay:Bool;

    public function new(refHUD:FightHUD) {
        super();
        fightHUD = refHUD;
        botPlay = ClientPrefs.getGameplaySetting('botplay');

        // Binej battle sprite
        binejBattle = new Character(dad.x, dad.y, "binejBattle");
        binejBattle.alpha = 0.00001;
        add(binejBattle);

        // BF melted
        bfMelted = new FlxSprite(boyfriend.x - 20, boyfriend.y - 20);
        bfMelted.frames = Paths.getSparrowAtlas("characters/bf_melted");
        bfMelted.animation.addByPrefix("default", "default", 24, false);
        bfMelted.alpha = 0.00001;
        add(bfMelted);

        // Effects
        bloodBinej = new FlxSprite(dad.x + 40, dad.y - 300);
        bloodBinej.frames = Paths.getSparrowAtlas("mouthman/blood");
        bloodBinej.animation.addByPrefix("default", "binej", 24, false);
        bloodBinej.flipX = true;
        bloodBinej.colorTransform.greenOffset = 50;
        bloodBinej.alpha = 0.00001;
        add(bloodBinej);

        hitFX = new FlxSprite(dad.x + 250, dad.y - 160);
        hitFX.frames = Paths.getSparrowAtlas("mouthman/hit");
        hitFX.animation.addByPrefix("hit", "hit", 24, false);
        hitFX.alpha = 0;
        add(hitFX);

        spitFX = new FlxSprite(boyfriend.x - 220, boyfriend.y - 110);
        spitFX.frames = Paths.getSparrowAtlas("mouthman/spit");
        spitFX.animation.addByPrefix("hit", "hit", 24, false);
        spitFX.animation.addByPrefix("dodged", "dodged", 24, false);
        spitFX.alpha = 0;
        add(spitFX);

        // Combo text
        comboText = new FlxSprite(gf.x + 75, gf.y - 75);
        comboText.loadGraphic(Paths.image("mouthman/texts/combo"));
        comboText.alpha = 0;
        add(comboText);

        // Feedback texts
        textEarly = new FlxSprite(boyfriend.x - 310, boyfriend.y - 290);
        textEarly.frames = Paths.getSparrowAtlas("mouthman/texts/early");
        textEarly.animation.addByPrefix("default", "default", 24, false);
        textEarly.setGraphicSize(Std.int(textEarly.width * 0.9), Std.int(textEarly.height * 0.8));
        textEarly.alpha = 0;
        add(textEarly);

        textFakedOut = new FlxSprite(boyfriend.x - 360, boyfriend.y - 380);
        textFakedOut.frames = Paths.getSparrowAtlas("mouthman/texts/faked_out");
        textFakedOut.animation.addByPrefix("default", "default", 24, false);
        textFakedOut.setGraphicSize(Std.int(textFakedOut.width * 0.9), Std.int(textFakedOut.height * 0.8));
        textFakedOut.alpha = 0;
        add(textFakedOut);

        textFail = new FlxSprite(boyfriend.x - 70, boyfriend.y - 180);
        textFail.frames = Paths.getSparrowAtlas("mouthman/texts/fail");
        textFail.animation.addByPrefix("default", "default", 24, false);
        textFail.setGraphicSize(Std.int(textFail.width * 0.94));
        textFail.alpha = 0;
        add(textFail);

        textGood = new FlxSprite(boyfriend.x - 30, boyfriend.y - 170);
        textGood.frames = Paths.getSparrowAtlas("mouthman/texts/good");
        textGood.animation.addByPrefix("default", "default", 24, false);
        textGood.setGraphicSize(Std.int(textGood.width * 0.94));
        textGood.alpha = 0;
        add(textGood);

        textPerfect = new FlxSprite(boyfriend.x - 90, boyfriend.y - 240);
        textPerfect.frames = Paths.getSparrowAtlas("mouthman/texts/perfect");
        textPerfect.animation.addByPrefix("default", "default", 24, false);
        textPerfect.setGraphicSize(Std.int(textPerfect.width * 0.94));
        textPerfect.alpha = 0;
        add(textPerfect);

        // Attack bar and arrow
        atkBar = new FlxSprite(boyfriend.x - 112, boyfriend.y - 112);
        atkBar.frames = Paths.getSparrowAtlas("mouthman/ui/bar_normal");
        atkBar.animation.addByPrefix("appear", "appear", 48, false);
        atkBar.animation.addByPrefix("bop", "bop", 24, false);
        atkBar.offset.set(7, 34);
        atkBar.setGraphicSize(Std.int(atkBar.width * 0.9));
        atkBar.alpha = 0;
        add(atkBar);

        atkBarHit = new FlxSprite(boyfriend.x - 127, boyfriend.y - 155);
        atkBarHit.frames = Paths.getSparrowAtlas("mouthman/ui/bar_hit_normal");
        atkBarHit.animation.addByPrefix("perfect", "perfect", 24, false);
        atkBarHit.animation.addByPrefix("good", "good", 24, false);
        atkBarHit.animation.addByPrefix("fail", "fail", 24, false);
        atkBarHit.offset.set(0, 10);
        atkBarHit.setGraphicSize(Std.int(atkBarHit.width * 0.9));
        atkBarHit.alpha = 0;
        add(atkBarHit);

        secretBar = new FlxSprite(boyfriend.x - 112, boyfriend.y - 112);
        secretBar.frames = Paths.getSparrowAtlas("mouthman/ui/bar_secret");
        secretBar.animation.addByPrefix("appear", "appear", 48, false);
        secretBar.animation.addByPrefix("bop", "bop", 24, false);
        secretBar.offset.set(7, 34);
        secretBar.setGraphicSize(Std.int(secretBar.width * 0.9));
        secretBar.alpha = 0;
        add(secretBar);

        secretBarHit = new FlxSprite(boyfriend.x - 127, boyfriend.y - 155);
        secretBarHit.frames = Paths.getSparrowAtlas("mouthman/ui/bar_hit_secret");
        secretBarHit.animation.addByPrefix("perfect", "perfect", 24, false);
        secretBarHit.animation.addByPrefix("good", "good", 24, false);
        secretBarHit.animation.addByPrefix("fail", "fail", 24, false);
        secretBarHit.offset.set(0, 10);
        secretBarHit.setGraphicSize(Std.int(secretBarHit.width * 0.9));
        secretBarHit.alpha = 0;
        add(secretBarHit);

        atkArrow = new FlxSprite(boyfriend.x - 20, boyfriend.y + 39);
        atkArrow.loadGraphic(Paths.image("mouthman/ui/arrow"));
        atkArrow.setGraphicSize(Std.int(atkArrow.width * 0.9));
        atkArrow.origin.set(101, 37);
        atkArrow.alpha = 0;
        add(atkArrow);

        atkArrowHit = new FlxSprite(boyfriend.x - 30, boyfriend.y + 34);
        atkArrowHit.frames = Paths.getSparrowAtlas("mouthman/ui/arrow_hit");
        atkArrowHit.animation.addByPrefix("hit", "hit", 24, false);
        atkArrowHit.setGraphicSize(Std.int(atkArrowHit.width * 0.94));
        atkArrowHit.origin.set(111, 42);
        atkArrowHit.alpha = 0;
        add(atkArrowHit);
    }

    public function updateArrowAngle(songPos:Float):Float {
        var crochet = Conductor.crochet / 1000;
        var angle = 8.7 - (61 * Math.sin(songPos * Math.PI / crochet));
        atkArrow.angle = angle;
        return angle;
    }

    public function handleAttackInput(angle:Float):Int {
        var curWindow = window[secret ? "secret" : "def"];
        var hitQuality = 0;

        for (range in curWindow[1])
            if (angle >= range[0] && angle <= range[1])
                hitQuality = 2;

        if (hitQuality == 0)
            for (range in curWindow[0])
                if (angle >= range[0] && angle <= range[1])
                    hitQuality = 1;
        
        atkArrow.alpha = 0;
        atkArrowHit.angle = angle;
        atkArrowHit.alpha = 1;
        atkArrowHit.animation.play("hit");
        FlxTween.tween(atkArrowHit, {alpha: 0}, 1, {ease: FlxEase.quartIn});
        
        if(secret){
            secretBar.alpha = 0;
            secretBarHit.alpha = 1;
            secretBarHit.animation.play((hitQuality == 2) ? "perfect" : (hitQuality == 1) ? "good" : "fail");
            FlxTween.tween(secretBarHit, {alpha: 0}, 1, {ease: FlxEase.quartIn});
        }
        else{
            atkBar.alpha = 0;
            atkBarHit.alpha = 1;
            atkBarHit.animation.play((hitQuality == 2) ? "perfect" : (hitQuality == 1) ? "good" : "fail");
            FlxTween.tween(atkBarHit, {alpha: 0}, 1, {ease: FlxEase.quartIn});
        }
        return hitQuality;
    }

    public function onEvent(value1:String, value2:String) {
        state = Idle;
        canAttack = canDodge = hasAttacked = hasDodged = fellForFakeout = spitAttack = isFakeout = false;
        attackType = (value2 != "") ? value2 : "punch";
        secret = PlayState.storyDifficulty == 2 && FlxG.random.bool(10);

        if (value1 == "bf") {
            state = Attacking(3, false, 0, secret);
            canAttack = true;

            if(secret){
                secretBar.animation.play("appear");
                secretBar.alpha = 1;
            } else{
                atkBar.animation.play("appear");
                atkBar.alpha = 1;
            }

            FlxTween.tween(atkArrow, {alpha: 1}, 0.25, {ease: FlxEase.circIn});
            boyfriend.playAnim("pre-attack", true);
            boyfriend.specialAnim = true;
            focusCamera("bf_attack");
        } else if (value1 == "fakeout") {
            state = Dodging(4, false, true, attackType, false);
            isFakeout = true;
            canDodge = true;
            fightHUD.startDodge(2, true, false);
            if (dad.animation.curAnim.name == "idle"){
                dad.alpha = 0.00001;
                binejBattle.alpha = 1;
            }
            // binejBattle.playAnim("fakeout_pre");
            focusCamera("binej_attack");
        } else {
            var beats = (Std.parseInt(value1) != null) ? Std.parseInt(value1) : 3;
            state = Dodging(beats, false, false, attackType, attackType == "spit");
            spitAttack = attackType == "spit";
            canDodge = true;
            fightHUD.startDodge(beats, false, spitAttack);
            if (dad.animation.curAnim.name == "idle"){
                dad.alpha = 0.00001;
                binejBattle.alpha = 1;
            }
            // binejBattle.playAnim(attackType + "_pre");
            focusCamera("binej_attack");
        }
    }

    public function beatHit() {
        switch (state) {
            case Attacking(beatsLeft, hasAttacked, hitQuality, secret):
                if (beatsLeft > 0 && !hasAttacked) {
                    if(secret) secretBar.animation.play("bop");
                    else atkBar.animation.play("bop");
                    boyfriend.playAnim("pre-attack", true);
                    state = Attacking(beatsLeft - 1, hasAttacked, hitQuality, secret);
                } else {
                    boyfriend.playAnim("attack", true);
                    boyfriend.specialAnim = true;
                    if (hasAttacked && hitQuality > 0) {
                        state = AttackSuccess;
                        atkCombo++;
                        fightHUD.opp.hp -= hitQuality / 2;
                        if (fightHUD.opp.hp <= 0) {
                            fightHUD.opp.hp = 0;
                            state = KnockOut;
                            binejBattle.playAnim("ko");
                            dad.alpha = 0.00001;
                            binejBattle.alpha = 1;
                            FlxG.sound.play(Paths.sound("ko_spin"));
                            FlxTween.tween(PlayState.instance.camHUD, {alpha: 0}, 5, {ease: FlxEase.quintOut});
                            focusCamera("ko");
                            if (onKnockOut != null) onKnockOut();
                            new FlxTimer().start(42 / 24, function(tmr) FlxG.sound.play(Paths.sound("ko_fall")));
                            new FlxTimer().start(4.3, function(tmr) {
                                gf.playAnim("cheer", true);
                                boyfriend.playAnim("hey", true);
                            });
                        } else {
                            dad.playAnim("hurt", true);
                            dad.specialAnim = true;
                            dad.animation.finishCallback = function(name:String)
                            {
                                if(name == "hurt")
                                    dad.playAnim("angry", true);
                            };
                            // fightHUD.healthHeartsOpponent[fightHUD.ply.hp].animation.play("explode");
                            bloodBinej.alpha = 1;
                            bloodBinej.animation.play("default");
                            hitFX.alpha = 1;
                            hitFX.animation.play("hit");
                            new FlxTimer().start(10 / 24, function(tmr) bloodBinej.alpha = 0);
                            new FlxTimer().start(6 / 24, function(tmr) hitFX.alpha = 0);
                            FlxG.sound.play(Paths.sound("hurt_" + FlxG.random.int(1, 4)));
                            
                            if (hitQuality == 2){
                                textPerfect.animation.play("default");
                                textPerfect.alpha = 1;
                            } else {
                                textGood.animation.play("default");
                                textGood.alpha = 1;
                            }
                            new FlxTimer().start(21 / 24, function(tmr) {
                                textGood.alpha = 0;
                                textPerfect.alpha = 0;
                            });

                            FlxG.sound.play(Paths.sound(((hitQuality == 2) ? "punch" : "kick")), 0.7);
                            PlayState.instance.camGame.shake(0.015, 0.2);
                            PlayState.instance.camHUD.shake(0.005, 0.2);

                            if (atkCombo > 2 && fightHUD.ply.hp < fightHUD.ply.maxhp) {
                                atkCombo = 0;
                                fightHUD.ply.hp++;
                                comboText.alpha = 1;
                                comboText.y = gf.y - 75;
                                FlxTween.tween(comboText.scale, {x: 0.75, y: 0.75}, 1, {ease: FlxEase.backIn});
                                FlxTween.tween(comboText, {y: gf.y, alpha: 0}, 1, {ease: FlxEase.quartIn});
                                gf.playAnim("kiss", true);
                                fightHUD.healthHeartsPlayer[fightHUD.ply.hp - 1].animation.play("appear");
                            }

                            PlayState.instance.health += (hitQuality == 2) ? 0.2 : 0.1;
                        }
                    } else {
                        state = AttackFail;
                        atkCombo = 0;
                        dad.playAnim("dodge", true);
                        dad.specialAnim = true;
                        dad.alpha = 1;
                        binejBattle.alpha = 0.00001;
                        
                        new FlxTimer().start(11 / 24, function(tmr) {
                            dad.playAnim("idle", true);
                            focusCamera("dad");
                        });
                        textFail.animation.play("default");
                        textFail.alpha = 1;
                        new FlxTimer().start(21 / 24, function(tmr) textFail.alpha = 0);

                        if(!hasAttacked){
                            FlxTween.tween((secret) ? secretBar : atkBar, {alpha: 0}, 1, {ease: FlxEase.quartIn});
                            FlxTween.tween(atkArrow, {alpha: 0}, 1, {ease: FlxEase.quartIn});
                        }
                        FlxG.sound.play(Paths.sound("badnoise" + FlxG.random.int(1, 3)), 0.5);
                    }
                    fightHUD.updateHealthBars(fightHUD.opp.hp, fightHUD.ply.hp);
                    focusCamera(null);
                }
            case Dodging(beatsLeft, hasDodged, isFakeout, attackType, spitAttack):
                if (beatsLeft > 0) {
                    if (dad.animation.curAnim.name == "idle"){
                        dad.alpha = 0.00001;
                        binejBattle.alpha = 1;
                    }
                    var count = (isFakeout && beatsLeft > 2) ? beatsLeft - 2 : beatsLeft;
                    fightHUD.atkCounter.animation.play(Std.string(count));
                    fightHUD.atkDodge.animation.play("bop");
                    if(isFakeout){
                        switch(beatsLeft){
                            case 4:
                                binejBattle.playAnim("fakeout_pre", true);
                            case 3:
                                binejBattle.playAnim("fakeout_pre", true);
                            case 2:
                                binejBattle.playAnim("fakeout", true);
                                FlxG.sound.play(Paths.sound("fakeout_whoosh"), 0.7);
                            case 1:
                                binejBattle.playAnim("uppercut_pre", true);
                        }
                    } 
                    else 
                        binejBattle.playAnim(attackType + "_pre");
                    state = Dodging(beatsLeft - 1, hasDodged, isFakeout, attackType, spitAttack);
                } else {
                    dad.alpha = 0.00001;
                    binejBattle.alpha = 1;
                    binejBattle.playAnim(isFakeout ? "uppercut" : attackType, true);
                    var sound = (attackType == "kick") ? "kick" : (attackType == "spit") ? "acid_hit" : "punch";
                    if (!spitAttack) {
                        FlxG.sound.play(Paths.sound(sound + "_whoosh_" + FlxG.random.int(1, 4)), 0.9);
                    }
                    if (hasDodged) {
                        state = DodgeSuccess;
                        boyfriend.playAnim("dodge", true);
                        boyfriend.specialAnim = true;
                        if (spitAttack) {
                            spitFX.animation.play("dodged");
                            spitFX.alpha = 1;
                            new FlxTimer().start(9 / 24, function(tmr) spitFX.alpha = 0);
                            FlxG.sound.play(Paths.sound("acid_dodged"), 0.35);
                        }
                    } else {
                        state = isFakeout ? Fakeout : spitAttack ? SpitGameOver : DodgeFail;
                        boyfriend.playAnim("hurt", true);
                        boyfriend.specialAnim = true;

                        FlxTween.tween(fightHUD.atkCounter.scale, {x: 0.75, y: 0.75}, 0.25, {ease: FlxEase.backInOut});
                        FlxTween.tween(fightHUD.atkDodge, {alpha: 0}, 0.6, {ease: FlxEase.circIn});
                        FlxTween.tween(fightHUD.atkCounter, {alpha: 0}, 0.75, {ease: FlxEase.quartIn});

                        if (spitAttack) {
                            spitFX.animation.play("hit");
                            spitFX.alpha = 1;
                            new FlxTimer().start(22 / 24, function(tmr) spitFX.alpha = 0);
                            bfMelted.alpha = 1;
                            bfMelted.animation.play("default", false, false, 2);
                            boyfriend.alpha = 0;
                            PlayState.instance.camGame.alpha = 0.00001;
                            PlayState.instance.camHUD.alpha = 0.00001;
                            for (spr in [dad, binejBattle, bfMelted, spitFX]) {
                                FlxTween.tween(spr, {x: spr.x - 250, y: spr.y - 550}, 1.45, {ease: FlxEase.cubeOut});
                                spr.cameras = [PlayState.instance.camOther];
                            }
                            FlxTween.tween(PlayState.instance.camOther, {zoom: 0.65}, 1.45, {ease: FlxEase.cubeOut});
                            FlxG.sound.play(Paths.sound("trolled"));
                            PlayState.instance.health = 0.001;
                            new FlxTimer().start(0.08, function(tmr) {
                                GameOverSubstate.characterName = "bf_melted";
                                // Fix here
                                // PlayState.instance.setGameOver();
                            });
                            new FlxTimer().start(1.5, function(tmr) {
                                // Fix here
                                FlxG.sound.play(Paths.sound("acid_hit"), 0.75);
                            });
                        } else {
                            fightHUD.ply.hp--;
                            fightHUD.healthHeartsPlayer[fightHUD.ply.hp].animation.play("explode");
                            PlayState.instance.health -= 0.3;
                            gf.playAnim("sad", true);
                            gf.specialAnim = true;
                            if (isFakeout) {
                                textFakedOut.animation.play("default");
                                textFakedOut.alpha = 1;
                                fellForFakeout = true;
                                new FlxTimer().start(17 / 24, function(tmr) textFakedOut.alpha = 0);
                            }
                            // fightHUD.atkCounter.animation.play(Std.string(count));
                            // fightHUD.atkDodge.animation.play("bop");
                            FlxG.sound.play(Paths.sound(sound), 0.7);
                            PlayState.instance.camGame.shake(0.015, 0.2);
                            PlayState.instance.camHUD.shake(0.005, 0.2);
                            if (fightHUD.ply.hp <= 0) {
                                PlayState.instance.health = 0.001;
                                new FlxTimer().start(0.03, function(tmr) {
                                    if (attackType == "kick" || attackType == "uppercut" || isFakeout) {
                                        GameOverSubstate.characterName = "bf_kicked";
                                    }
                                    // Fix here
                                    // PlayState.instance.setGameOver();
                                });
                            }
                        }
                    }
                    new FlxTimer().start(11 / 24, function(tmr) {
                        dad.alpha = 1;
                        binejBattle.alpha = 0.00001;
                        dad.playAnim(fellForFakeout ? "hey" : "idle", true);
                        dad.specialAnim = fellForFakeout;
                        focusCamera("dad");
                    });
                    fightHUD.updateHealthBars(fightHUD.opp.hp, fightHUD.ply.hp);
                    focusCamera(null);
                }
            case SpitGameOver:
                if (FlxG.keys.anyJustPressed([SPACE, ENTER, ESCAPE])) {
                    // Fix here
                    // FlxG.sound.fadeOut(0.5, 0, null, null, "acid_hit");
                    // FlxG.sound.fadeOut(0.5, 0, null, null, "trolled");
                    // PlayState.instance.restartSong(false);
                }
            case KnockOut:
                // Handled in timers
            case Idle, AttackSuccess, AttackFail, DodgeSuccess, DodgeFail, Fakeout:
                state = Idle;
                fightHUD.updateHealthBars(fightHUD.opp.hp, fightHUD.ply.hp);
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        switch (state) {
            case Attacking(beatsLeft, hasAttacked, hitQuality, secret):
                var theAngle = updateArrowAngle(Conductor.songPosition / 1000);
                if (FlxG.keys.justPressed.SPACE && canAttack) {
                    canAttack = false;
                    hasAttacked = true;
                    var newHitQuality = handleAttackInput(theAngle);
                    if (newHitQuality == 2) {
                        textPerfect.animation.play("default");
                        textPerfect.alpha = 1;
                        new FlxTimer().start(21 / 24, function(tmr) textPerfect.alpha = 0);
                    } else if (newHitQuality == 1) {
                        textGood.animation.play("default");
                        textGood.alpha = 1;
                        new FlxTimer().start(21 / 24, function(tmr) textGood.alpha = 0);
                    } else {
                        textFail.animation.play("default");
                        textFail.alpha = 1;
                        new FlxTimer().start(21 / 24, function(tmr) textFail.alpha = 0);
                        FlxG.sound.play(Paths.sound("badnoise" + FlxG.random.int(1, 3)), 0.5);
                    }
                    state = Attacking(beatsLeft, true, newHitQuality, secret);
                }
            case Dodging(beatsLeft, hasDodged, isFakeout, attackType, spitAttack):
                if (FlxG.keys.justPressed.SPACE && canDodge && !botPlay) {
                    canDodge = false;
                    if (beatsLeft == 0) {
                        hasDodged = true;
                        fightHUD.atkCounter.color = 0xAAFFBB;
                    } else {
                        hasDodged = false;
                        if (isFakeout) {
                            fellForFakeout = true;
                            textEarly.animation.play("default");
                            textEarly.alpha = 1;
                            new FlxTimer().start(17 / 24, function(tmr) textEarly.alpha = 0);
                        }
                    }
                    fightHUD.handleDodgeInput(beatsLeft, isFakeout, spitAttack);
                    FlxTween.tween(fightHUD.atkCounter.scale, {x: 0.75, y: 0.75}, 0.25, {ease: FlxEase.backInOut});
                    FlxTween.tween((spitAttack || fightHUD.ply.hp == 1) ? fightHUD.spaceDeath : fightHUD.atkDodge, {alpha: 0}, 0.6, {ease: FlxEase.circIn});
                    FlxTween.tween(fightHUD.atkCounter, {alpha: 0}, 0.75, {ease: FlxEase.quartIn});
                    state = Dodging(beatsLeft, hasDodged, isFakeout, attackType, spitAttack);
                }
            case SpitGameOver:
                if (FlxG.keys.anyJustPressed([SPACE, ENTER, ESCAPE])) {
                    // Fix here
                    // FlxG.sound.fadeOut(0.5, 0, null, null, "acid_hit");
                    // FlxG.sound.fadeOut(0.5, 0, null, null, "trolled");
                    // PlayState.instance.restartSong(false);
                }
            default:
                // Do nothing
        }
    }

    // Camera positions could use some work
    function focusCamera(target:String) {
        var cam = PlayState.instance.camGame;
        var zoom = (target == "ko") ? 0.8 : 0.65;
        var duration = (target == null) ? 0.25 : 0.75;
        var ease = (target == null) ? FlxEase.cubeInOut : FlxEase.circOut;
        if (target == "bf_attack") {
            FlxTween.tween(cam, {zoom: 0.85}, duration, {ease: ease});
            // PlayState.instance.camFollow.setPosition(boyfriend.x + 200, boyfriend.y + 300);
        } else if (target == "binej_attack") {
            FlxTween.tween(cam, {zoom: 0.85}, duration, {ease: ease});
            // PlayState.instance.camFollow.setPosition(dad.x + 200, dad.y + 300);
        } else if (target == "ko") {
            FlxTween.tween(cam, {zoom: zoom}, duration, {ease: FlxEase.quintOut});
            // PlayState.instance.camFollow.setPosition(binejBattle.x + 200, binejBattle.y + 200);
        } else if (target == "dad") {
            FlxTween.tween(cam, {zoom: zoom}, duration, {ease: FlxEase.quintOut});
            // PlayState.instance.camFollow.setPosition(dad.x + 200, dad.y + 300);
        } else {
            FlxTween.tween(cam, {zoom: zoom}, duration, {ease: ease});
            PlayState.instance.defaultCamZoom = zoom;
        }
    }

    var boyfriend(get, never):Character;
    var dad(get, never):Character;
    var gf(get, never):Character;
    function get_boyfriend() return PlayState.instance.boyfriend;
    function get_dad() return PlayState.instance.dad;
    function get_gf() return PlayState.instance.gf;
}