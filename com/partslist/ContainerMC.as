package com.partslist{

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.text.*;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import com.main.*;
	import com.ddlist.*;
	import com.parts.*;
	import com.preloader.Preloader;



	public class ContainerMC extends MovieClip {

		public var partMC:PartMC;
		public var tipMC:ThumbMC;
		public var preloader:Preloader;
		public var outline:MovieClip;
		public var imgMC:MovieClip;
		public var loader:Loader;
		public var path:String='';

		public var partCls:Parts;
		
		// db action values 
		public var AID:Number    = 0;
		public var PARTID:Number = 0;
		public var PARTLBL:String = '';
		public var PARTPRICE:Number = 0;
		public var PARTFROM:String = '';
		public var PARTTYPE:String = '';
		
		public function ContainerMC($path:String,$part_id:Number,$icon:String,$lbl:String,$price:Number,$monthlyPrice:Number,$des:String,$manu:String,$SKU:String,$status:Number,$effected:String , $from:String ) {
			partMC = new PartMC();
			partMC.name=$lbl;
			partMC.PART_ID=$part_id;
			partMC.imgSrc=$icon;
			partMC.partlbl=$lbl;
			partMC.partPrice=$price;
			partMC.montlyPartPrice = $monthlyPrice;
			partMC.partDescription=$des;
			partMC.partManufacture=$manu;
			partMC.partSKU=$SKU;
			partMC.partStatus=$status;
			partMC.FROM=$from;
			partMC.graphics.lineStyle(2, 0xcdcdcd);
			partMC.graphics.beginFill(0xFFFFFF);
			partMC.graphics.drawRoundRect(0, 0, 170 , 133 , 15, 15);
			partMC.graphics.endFill();
			addChild(partMC);

			path=$path;

			partMC.buttonMode = true;

			setImages($path + $icon);
			setLabelText($lbl);
			setPriceText($price ,$monthlyPrice );
			
		}
		
		
		
		/*   Other functions     */

		public function selectedContainer():void {
			outline= new MovieClip();
			outline.graphics.lineStyle(2, 0xfd0000);
			outline.graphics.drawRoundRect(0, 0, 172 , 135 , 10, 10);
			partMC.addChild(outline);
		}

		public function removeSelected():void {
			//partMC.removeChild(outline);
		}


		




		/*  
			***********************************************************************************************************
			Draw Movieclips
		*/
		
		public function setTotalPrice(txt:Number):void{
			var totalPrice:TextField = new TextField();
			totalPrice.selectable=false;
			totalPrice.text="Price: $"+String(txt);
			totalPrice.height=20;
			totalPrice.x=5;
			totalPrice.y=115;
			partMC.addChild(totalPrice);
			totalPrice.setTextFormat(PartTextFormat.monthlyPriceStyle());
		}
		
		
		public function setLabelText(txt:String):void {
			var lblTxt:TextField = new TextField();
			lblTxt.selectable=false;
			lblTxt.text=txt;
			lblTxt.x=5;
			lblTxt.y=85;
			lblTxt.width=160;
			lblTxt.height=20;
			partMC.addChild(lblTxt);
			lblTxt.setTextFormat(PartTextFormat.setPartLabelStyle());
		}
		
		public function setPriceText(totalPrice:Number = 0 , monthlyPrice:Number = 0 ):void {
			var priceTxt:TextField = new TextField();
			priceTxt.selectable=false;
			
			priceTxt.text="$"+String(totalPrice);
			
			
			priceTxt.height=22;
			priceTxt.x=3;
			priceTxt.y=100;
			partMC.addChild(priceTxt);
			priceTxt.setTextFormat(PartTextFormat.setPartPriceStyle());
		}


		function setImages(url:String):void {
			imgMC = new MovieClip();
			loadImage(url);
		}

		function loadImage(url:String):void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, imageLoaded );
			loader.load(new URLRequest(url));
		}

		function imageLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			imgMC.addChild(thumbContent);
			imgMC.x=1;
			imgMC.y=1;
			partMC.addChild(imgMC);
			loader.unload();
			resizeMe(imgMC , 170 , 87 , false);
		}

		function resizeMe(mc:MovieClip, maxW:Number, maxH:Number=0, constrainProportions:Boolean=true):void {
			maxH=maxH==0?maxW:maxH;
			mc.width=maxW;
			mc.height=maxH;
			if (constrainProportions) {
				mc.scaleX<mc.scaleY?mc.scaleY=mc.scaleX:mc.scaleX=mc.scaleY;
			}
		}



	}//$class
}//$package