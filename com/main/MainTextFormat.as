package com.main{

	import flash.display.Sprite;
	import flash.text.*;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	
	public class MainTextFormat extends Sprite {

		function MainTextFormat():void {}
				
		public static function setLoginError():TextFormat{
			var msg_format:TextFormat = new TextFormat();
			msg_format.italic = true;
			msg_format.bold = true;
			return msg_format;
		}
		
		
		public static function setBreadCrumbFormat():TextFormat{
			var msg_format:TextFormat = new TextFormat();
			msg_format.bold = true;
			//msg_format.size = "20px";
			return msg_format;
		}
		
		
		
	} // $class
}