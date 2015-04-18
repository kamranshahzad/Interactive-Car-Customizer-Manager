package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import flash.text.*;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import com.msgwin.*;
	import com.preloader.Preloader;
	import gs.TweenLite;
	import com.stringutil.StringUtils;
	import com.adobe.serialization.json.JSON;


	public class RemoteEngine extends MovieClip {



		public var key:String = 'http://localhost/addoncars/amfphp/gateway.php';
		//public var key:String = 'http://www.realtypakistan.net/pro/amfphp/gateway.php';

		public var hostDomain:String='';
		public var gateWay:String='';
		public var effectAccessoriesFiles:String='';
		public var accessoriesIconFiles:String='';
		public var smallViewsFiles:String='';
		public var canvesViewsFiles:String='';
		public var backgroundFiles:String='';
		public var uploadScript:String='';
		public var InteriorFiles:String='';
		
		
		public var preloader:Preloader;
		public var msgCls:MsgWin;
		public var blackWall:MovieClip;
		
		
		
		public function RemoteEngine() {
			loadConfigurations();
		}


		function loadConfigurations() {
			
			var _service = new NetConnection();
			_service.connect(key);
			var responder=new Responder(get_configurations,onFault);
			_service.call("AddOnCars.getVariable", responder , 'remote_config');
		}
		function get_configurations(rs:Object) {
			var resultArr:Array=JSON.decode(rs.serverInfo.initialData[0][2]);
			
			hostDomain = resultArr[0].hostDomain;
			gateWay=resultArr[0].gateWay;
			effectAccessoriesFiles=resultArr[0].effected;
			accessoriesIconFiles=resultArr[0].icons;
			smallViewsFiles=resultArr[0].smallviews;
			canvesViewsFiles=resultArr[0].canvesviews;
			backgroundFiles=resultArr[0].backgrounds;
			uploadScript=resultArr[0].uploadScript;
			InteriorFiles=resultArr[0].InteriorFiles;
			this.dispatchEvent(new EngineCompleteEvent());
		}

		public function saveConfigurations($hostDomain:String , $gateWay:String ,$effected:String , $icons:String , $smallviews:String , $canvesviews:String ,$backgrounds:String ,  $uploadScript:String , $InteriorFiles:String) {
			var $val:String=encodeString($hostDomain,$gateWay,$effected,$icons,$smallviews,$canvesviews,$backgrounds,$uploadScript,$InteriorFiles);
			var _service = new NetConnection();
			_service.connect(key);
			var responder=new Responder(set_configurations,onFault);
			_service.call("AddOnCars.setVariable", responder , 'remote_config' , $val );
		}

		public function encodeString($hostDomain , $gateWay ,$effected , $icons , $smallviews , $canvesviews ,$backgrounds , $uploadScript , $InteriorFiles) {
			var tempArr:Array = new Array();
			var obj:Object = new Object();
			obj.hostDomain=$hostDomain;
			obj.gateWay=$gateWay;
			obj.effected=$effected;
			obj.icons=$icons;
			obj.smallviews=$smallviews;
			obj.canvesviews=$canvesviews;
			obj.backgrounds=$backgrounds;
			obj.uploadScript=$uploadScript;
			obj.InteriorFiles=$InteriorFiles;
			tempArr.push(obj);
			return JSON.encode(tempArr);
		}

		public function set_configurations(rs:Object) {
			//trace(rs);
		}

		public function onFault(f:Event ) {
			trace("There was a problem");
		}

		/*
		******************************************************************************
		Helpers
		*/

		/* PreLoader */
		public function pleaseWait($msg:String , xPos:Number = 260 , yPos:Number = 200 ) {
			preloader= new Preloader($msg);
			addChild(preloader);
			preloader.x=xPos;
			preloader.y=yPos;
		}
		public function endWait() {
			if (preloader) {
				removeChild(preloader);
				preloader=null;
			}
		}

		/* Message Window */
		public function buildMsgWindow(xLoc:Number = 100 , yLoc:Number= 50):void {
			msgCls = new MsgWin();
			addChild(msgCls);
			msgCls.x=xLoc;
			msgCls.y=yLoc;
			TweenLite.from(msgCls, 1, {alpha:0  });
			TweenLite.to(msgCls, 1, {alpha:1});
		}
		public function destroyMsgWindow():void {
			if (msgCls) {
				removeChild(msgCls);
				msgCls=null;
			}
		}

		public function buildBlackWall(xDim:Number , yDim:Number ) {
			if (!blackWall) {
				blackWall = new MovieClip();
				blackWall.graphics.lineStyle(0, 0x737171);
				blackWall.graphics.beginFill(0x000000);
				blackWall.graphics.drawRect(0,0,xDim,yDim);
				blackWall.graphics.endFill();
				blackWall.alpha=0.7;
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
		
		
		public function setGridTextFormat():TextFormat {
			var tf:TextFormat = new TextFormat();
			tf.font="Verdana";
			tf.bold=true;
			tf.color=0xFF6666;
			tf.size=12;
			return tf;
		}
		
		public function setInfoTextFormat(isErr:Boolean = false):TextFormat {
			var tf:TextFormat = new TextFormat();
			tf.font="Verdana";
			tf.bold=true;
			if(isErr){
				tf.italic = true;
			}
			tf.color=0xc62020;
			tf.size=12;
			return tf;
		}
		





	}//$class
}//$package