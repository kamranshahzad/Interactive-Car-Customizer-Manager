package com.ddlist{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.*;
	
	
	
	public class ContainerList extends MovieClip {

		public var simpleListCls:SimpleList;
		public var wheelSizeListCls:WheelSizeList;
		public static var infoTxt:TextField;
		public static var currentVIEW:String = '';
		private var _data:Array = new Array();



		public function ContainerList() {
			
			createListInfoText();
			createSimpleList(1);
			
			
		}
		
	
		

		//# SimpleList
		public function createSimpleList(part_type_id:Number):void {
			if (! simpleListCls) {
				simpleListCls = new SimpleList(part_type_id );
				addChild(simpleListCls);
			}
		}
		public function removeSimpleList():void {
			if (simpleListCls) {
				removeChild(simpleListCls);
				simpleListCls=null;
			}
		}

		//# WheelSizeList
		public function createWheelSizeList():void {
			if (! wheelSizeListCls) {
				wheelSizeListCls=new WheelSizeList();
				addChild(wheelSizeListCls);
			}
		}
		public function removeWheelSizeList():void {
			if (wheelSizeListCls) {
				removeChild(wheelSizeListCls);
				wheelSizeListCls=null;
			}
		}

		
		//# Info Text
		private function createListInfoText():void {
			infoTxt = new TextField();
			infoTxt.selectable = false;
			infoTxt.height = 20;
			infoTxt.width=400;
			infoTxt.x=200;
			infoTxt.y=45;
			addChild(infoTxt);
		}

		public static function setInfoText(txt:String):void {
			infoTxt.text="";
			infoTxt.text=txt;
			infoTxt.setTextFormat(CategoryText.infoTextFormat());
		}


	}// $class
}