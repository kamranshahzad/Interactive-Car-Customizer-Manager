package com.main{
	
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	
	import gs.TweenLite;
	import gs.OverwriteManager;
	
	
	public class BlackWall extends MovieClip{
		
		public var blackWall:MovieClip;
		
		
		public function BlackWall(){}
		

		/* BlackWall */
		public function buildBlackWall() {
			if (! blackWall) {
				blackWall = new MovieClip();
				blackWall.graphics.lineStyle(0, 0x737171);
				blackWall.graphics.beginFill(0x000000);
				blackWall.graphics.drawRect(0,0,1200,800);
				blackWall.graphics.endFill();
				blackWall.alpha=0.8;
				blackWall.y=0;
				blackWall.x=0;
				addChild(blackWall);
				TweenLite.from(blackWall , 1, {alpha:0});
			}
		}

		public function removeBlackWall() {
			if (blackWall) {
				removeChild(blackWall);
				blackWall=null;
			}
		}
		
		
	} //$class
} //$package