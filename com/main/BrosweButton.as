package com.main{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.events.ProgressEvent;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.display.SimpleButton;
	import flash.text.*;
	

	import gs.TweenLite;
	import gs.OverwriteManager;
	
	
	public class BrosweButton extends MovieClip{
		
		public var browseCanvesBtn_Front:SimpleButton;
		public var browseCanvesBtn_Rear:SimpleButton;
		public var browseCanvesBtn_Interior:SimpleButton;
		public var browseCanvesBtn_Other:SimpleButton;
		
		public var browseFVIEWBtn:SimpleButton;
		public var browseRVIEWBtn:SimpleButton;
		public var browseIVIEWBtn:SimpleButton;
		
		
		public function BrosweButton(){
			initBroweButtons();
		}
		
		
		/*
		******************************************************************************
		Broswe Buttons
		*/
		
		//init of broswe buttons
		public function initBroweButtons():void{
			addEventListener(Event.ADDED, brosweButtonObjectAdded);
		}
		
		public function brosweButtonObjectAdded(e:Event):void {
			createFrontViewButton();
			createFViewButton();
			createRViewButton();
			createIViewButton();
			removeEventListener(Event.ADDED, brosweButtonObjectAdded);
		}
		
		
		public function createFrontViewButton():void{
			if(!browseCanvesBtn_Front){
				browseCanvesBtn_Front = windowButton("&nbsp;&nbsp;&nbsp;Browse....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , "btn1");
				addChild(browseCanvesBtn_Front);
				browseCanvesBtn_Front.addEventListener(MouseEvent.CLICK, brosweFrontHandler );
				browseCanvesBtn_Front.x = 975;
				browseCanvesBtn_Front.y = 187;
			}
		}
		public function destroyFrontViewButton():void{
			if(browseCanvesBtn_Front){
				removeChild(browseCanvesBtn_Front);
				browseCanvesBtn_Front = null;
			}
		}
		
		public function createRearViewButton():void{
			if(!browseCanvesBtn_Rear){
				browseCanvesBtn_Rear = windowButton("&nbsp;&nbsp;&nbsp;Browse....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , "btn2");
				addChild(browseCanvesBtn_Rear);
				browseCanvesBtn_Rear.addEventListener(MouseEvent.CLICK, brosweRearHandler );
				browseCanvesBtn_Rear.x = 975;
				browseCanvesBtn_Rear.y = 217;
			}
		}
		public function destroyRearViewButton():void{
			if(browseCanvesBtn_Rear){
				removeChild(browseCanvesBtn_Rear);
				browseCanvesBtn_Rear = null;
			}
		}
		
		public function createInteriorViewButton():void{
			if(!browseCanvesBtn_Interior){
				browseCanvesBtn_Interior = windowButton("&nbsp;&nbsp;&nbsp;Browse....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , "btn3");
				addChild(browseCanvesBtn_Interior);
				browseCanvesBtn_Interior.addEventListener(MouseEvent.CLICK, brosweInteriorHandler );
				browseCanvesBtn_Interior.x = 975;
				browseCanvesBtn_Interior.y = 247;
			}
		}
		public function destroyInteriorViewButton():void{
			if(browseCanvesBtn_Interior){
				removeChild(browseCanvesBtn_Interior);
				browseCanvesBtn_Interior = null;
			}
		}
		
		public function createOtherViewButton():void{
			if(!browseCanvesBtn_Other){
				browseCanvesBtn_Other = windowButton("&nbsp;&nbsp;&nbsp;Browse....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , "btn4");
				addChild(browseCanvesBtn_Other);
				browseCanvesBtn_Other.addEventListener(MouseEvent.CLICK, brosweOtherHandler );
				browseCanvesBtn_Other.x= 975;
				browseCanvesBtn_Other.y = 277;
			}
		}
		public function destroyOtherViewButton():void{
			if(browseCanvesBtn_Other){
				removeChild(browseCanvesBtn_Other);
				browseCanvesBtn_Other = null;
			}
		}
		
		
		///
		public function createFViewButton():void{
			if(!browseFVIEWBtn){
				browseFVIEWBtn = windowButton("&nbsp;&nbsp;&nbsp;FVIEW....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , "sbtn1");
				addChild(browseFVIEWBtn);
				browseFVIEWBtn.addEventListener(MouseEvent.CLICK, brosweFVIEWHandler );
				browseFVIEWBtn.x = 1083;
				browseFVIEWBtn.y = 214;
			}
		}
		public function destroyFViewButton():void{
			if(browseFVIEWBtn){
				removeChild(browseFVIEWBtn);
			}
		}
		
		public function createRViewButton():void{
			if(!browseRVIEWBtn){
				browseRVIEWBtn = windowButton("&nbsp;&nbsp;&nbsp;RVIEW...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , "sbtn2");
				addChild(browseRVIEWBtn);
				browseRVIEWBtn.addEventListener(MouseEvent.CLICK, brosweRVIEWHandler );
				browseRVIEWBtn.x = 1083;
				browseRVIEWBtn.y =  243;
			}
		}
		public function destroyRViewButton():void{
			if(browseRVIEWBtn){
				removeChild(browseRVIEWBtn);
				browseRVIEWBtn = null;
			}
		}
		
		public function createIViewButton():void{
			if(!browseIVIEWBtn){
				browseIVIEWBtn = windowButton("&nbsp;&nbsp;&nbsp;IVIEW.....&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , "sbtn3");
				addChild(browseIVIEWBtn);
				browseIVIEWBtn.addEventListener(MouseEvent.CLICK, brosweIVIEWHandler );
				browseIVIEWBtn.x = 1083;
				browseIVIEWBtn.y =  272;
			}
		}
		public function destroyIViewButton():void{
			if(browseIVIEWBtn){
				removeChild(browseIVIEWBtn);
				browseIVIEWBtn = null;
			}
		}
		
		/*    Browse Buttons Workers  */
		function brosweFrontHandler(e:MouseEvent) {
			MovieClip(parent).effectCls.brosweFrontHandler();
		}
		function brosweRearHandler(e:MouseEvent) {
			MovieClip(parent).effectCls.brosweRearHandler();
		}

		function brosweInteriorHandler(e:MouseEvent) {
			MovieClip(parent).effectCls.brosweInteriorHandler();
		}

		function brosweOtherHandler(e:MouseEvent) {
			MovieClip(parent).effectCls.brosweOtherHandler();
		}



		function brosweFVIEWHandler(e:MouseEvent) {
			MovieClip(parent).effectCls.brosweFVIEWHandler();
		}
		function brosweRVIEWHandler(e:MouseEvent) {
			MovieClip(parent).effectCls.brosweRVIEWHandler();
		}
		function brosweIVIEWHandler(e:MouseEvent) {
			MovieClip(parent).effectCls.brosweIVIEWHandler();
		}
		
		/*
		*********************************************************************************************************************
		Button Checkers
		*/
		public function FrontVIEW_Checker(bool:Boolean):void{
			if(bool){
				destroyFrontViewButton();
			}else{
				createFrontViewButton();
			}
			
			destroyRearViewButton();
			destroyInteriorViewButton();
			destroyOtherViewButton();
		}
		
		public function RearVIEW_Checker(bool:Boolean):void{
			if(bool){
				destroyRearViewButton();
			}else{
				createRearViewButton();
			}
			
			destroyFrontViewButton();
			destroyInteriorViewButton();
			destroyOtherViewButton();
		}
		
		public function InteriorVIEW_Checker(bool:Boolean):void{
			if(bool){
				destroyInteriorViewButton();
			}else{
				createInteriorViewButton();
			}
			
			destroyFrontViewButton();
			destroyRearViewButton();
			destroyOtherViewButton();
		}
		
		public function OtherVIEW_Checker(bool:Boolean):void{
			if(bool){
				destroyOtherViewButton();
			}else{
				createOtherViewButton();
			}
			
			destroyFrontViewButton();
			destroyRearViewButton();
			destroyInteriorViewButton();
		}
		//
		public function FVIEW_Checker(bool:Boolean):void{
			if(bool){
				destroyFViewButton();
			}else{
				createFViewButton();
			}
		}
		public function RVIEW_Checker(bool:Boolean):void{
			if(bool){
				destroyRViewButton();
			}else{
				createRViewButton();
			}
		}
		public function IVIEW_Checker(bool:Boolean):void{
			if(bool){
				destroyIViewButton();
			}else{
				createIViewButton();
			}
		}
		
		
		
		/*
		*****************************************************************************************************************
		Design of buttons
		*/
		private var txt:String;
		private var gType:String;
		private var gColors:Array;
		private var gAlphas:Array;
		private var gRatio:Array;
		private var gMatrix:Matrix = new Matrix();
		private var gSpread:String;
		public var padding:Number=4;
		public var rad:Number=10;
		public var color:Array=[0x494848,0x767676];
		
		
		public function windowButton( _t:String , buttonAction:String ):SimpleButton {
			this.txt=_t;
			var btn:SimpleButton = new SimpleButton();
			btn.name = buttonAction;
			btn.upState=GuiButtonUp();
			btn.overState=GuiButtonOver();
			btn.downState=btn.upState;
			btn.hitTestState=btn.upState;
			btn.x = 220;
			btn.y = 105;
			return btn;
		}
		private function GuiButtonUp():Sprite {
			var btnLabel:TextField=GuiButtonText(this.txt);
			var btnUp:Sprite=GuiButtonGraphics(btnLabel);
			btnLabel.x = (btnUp.width - btnLabel.width) / 2;
			btnLabel.y = (btnUp.height - btnLabel.height) / 2;
			btnUp.addChild(btnLabel);
			return btnUp;
		}

		private function GuiButtonOver():Sprite {
			color=[color[1],color[0]];
			var btnLabel:TextField=GuiButtonText(this.txt);
			var btnDown:Sprite=GuiButtonGraphics(btnLabel);
			btnLabel.x = (btnDown.width - btnLabel.width) / 2;
			btnLabel.y = (btnDown.height - btnLabel.height) / 2;
			btnDown.addChild(btnLabel);
			return btnDown;
		}
		private function GuiButtonText( _txt:String ):TextField {
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.color=0xFFFFFF;
			txtFormat.font="Arial";
			txtFormat.size=12;
			//txtFormat.bold=true;
			txtFormat.align="center";

			var txtField:TextField = new TextField();
			txtField.htmlText=_txt;
			txtField.x=0;
			txtField.y=0;
			txtField.autoSize=TextFieldAutoSize.LEFT;
			txtField.antiAliasType=AntiAliasType.ADVANCED;
			txtField.selectable=false;
			txtField.setTextFormat( txtFormat );

			return txtField;
		}
		private function GuiButtonGraphics(btnLabel:TextField):Sprite {
			var _graphics:Sprite = new Sprite();
			gType=GradientType.LINEAR;
			gColors=color;
			gAlphas=[1,1];
			gRatio=[0,255];
			gMatrix.createGradientBox(btnLabel.width+padding, btnLabel.height+padding, 55, 0, 0);
			gSpread=SpreadMethod.PAD;

			_graphics.graphics.beginGradientFill(gType, gColors, gAlphas, gRatio, gMatrix, gSpread);
			_graphics.graphics.drawRoundRect(0, 0, btnLabel.width+padding, btnLabel.height+padding, rad, rad);
			_graphics.graphics.endFill();

			return _graphics;
		}
		
		

	} //$class
} //$package