package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import com.kam.*;
	import com.parts.*;
	import com.ddlist.*;
	import com.partslist.*;
	import com.msgwin.*;
	import gs.TweenLite;
	import com.stringutil.StringUtils;
	import com.adobe.serialization.json.JSON;


	public class Main extends MovieClip {
		
		//public static var key:String = 'http://www.addoncars.com/aoc/amfphp/gateway.php';
		//public var key:String = 'http://webdesigner-atlanta.com/clients/aoc/amfphp/gateway.php';
		public var key:String = 'http://localhost/addoncars/amfphp/gateway.php';
		
		
		public static var hostDomain:String             = '';
		public static var gateWay:String                = '';
		public static var effectAccessoriesFiles:String = '';
		public static var accessoriesIconFiles:String   = '';
		public static var smallViewsFiles:String        = '';
		public static var canvesViewsFiles:String       = '';
		public static var backgroundFiles:String        = '';
		public static var uploadScript:String           = '';

		public static var VIEW_CONTROL_VAR:String="FVIEW";// "FVIEW" , "RVIEW" , "IVIEW" ,"OVIEW" 
		public var loginCls:Login;
		public var dashCls:Dash;
		public var bgCls:Background;
		public var workCls:WorkSpace;
		public var breadCls:BreadCrumb;
		public var listCls:ContainerList;
		public var loaderCls:PreLoadAssets;
		public var wallCls:BlackWall;
		public var msgCls:MsgWin;
		public var formContainer:MovieClip;
		
		
		public static var vehicleID:Number = 0;  
		public static var trimID:Number = 0;
		public static var exteriorColorID:Number = 0;
		public static var interiorColorID:Number = 0;
		
		public function Main() {
			loadConfigurations();
		}
		
		
		/*
		************************************************************************************************************
		_load remoting configurations
		*/
		function loadConfigurations() {
			var _service = new NetConnection();
			_service.connect(key);
			var responder=new Responder(get_configurations,onFault);
			_service.call("AddOnCars.getVariable", responder , 'remote_config');
		}
		function get_configurations(rs:Object) {
			var resultArr:Array = JSON.decode(rs.serverInfo.initialData[0][2]);
			trace(rs.serverInfo.initialData[0][2]);
			
			hostDomain               = resultArr[0].hostDomain;
			gateWay    			     = hostDomain + resultArr[0].gateWay;
			effectAccessoriesFiles   = hostDomain + resultArr[0].effected;
			accessoriesIconFiles     = hostDomain + resultArr[0].icons;
			smallViewsFiles          = hostDomain + resultArr[0].smallviews;
			canvesViewsFiles         = hostDomain + resultArr[0].canvesviews;
			backgroundFiles          = hostDomain + resultArr[0].backgrounds;
			uploadScript             = hostDomain + resultArr[0].uploadScript;
			
			
			buildLoginWindow();
		}
		public function onFault(f:Event ) {
			trace("There was a problem");
		}

		
		
		/* ddlist */
		public function buildList():void {
			listCls = new ContainerList();
			addChild(listCls);
			listCls.x = 20;
			listCls.y = 515;
		}
		public function destroyList():void {
			if (listCls){
				removeChild(listCls);
				listCls = null;
			}
		}


		/* Login Window */
		public function buildLoginWindow():void {
			loginCls = new Login();
			addChild(loginCls);
		}
		public function destroyLoginWindow():void {
			if (loginCls) {
				removeChild(loginCls);
				loginCls = null;
			}
		}


		/* Dashboard */
		public function buildDashboard():void {
			dashCls = new Dash();
			addChild(dashCls);
		}
		public function destroyDashboard():void {
			if (dashCls) {
				removeChild(dashCls);
				dashCls = null;
			}
		}

		/* White Background */
		public function buildBackground():void {
			bgCls = new Background();
			addChild(bgCls);
		}
		public function destroyBackground():void {
			if (bgCls) {
				removeChild(bgCls);
				bgCls = null;
			}
		}

		/* Workspace */
		public function buildWorkspace():void {
			workCls = new WorkSpace();
			addChild(workCls);
		}
		public function destroyWorkspace():void {
			if (workCls) {
				removeChild(workCls);
				workCls = null;
			}
		}

		/* BreadCrumb */
		public function buildBreadCrumb():void {
			breadCls = new BreadCrumb();
			addChild(breadCls);
		}
		public function destroyBreadCrumb():void {
			if (breadCls) {
				removeChild(breadCls);
				breadCls = null;
			}
		}

		
		/* Dynamic Form Load Containers */
		public function buildFormContainer():void {
			formContainer = new MovieClip();
			addChild(formContainer);
		}
		public function destroyFormContainer():void {
			if (formContainer) {
				removeChild(formContainer);
				formContainer = null;
			}
		}

		
		/* Black Wall */
		public function CreateBlackWall():void {
			wallCls = new BlackWall();
			wallCls.buildBlackWall();
			addChild(wallCls);
		}
		public function destroyBlackWall():void {
			if (wallCls) {
				removeChild(wallCls);
				wallCls = null;
			}
		}

		/* PreLoader */
		public function buildPreloader():void {
			loaderCls = new PreLoadAssets();
			addChild(loaderCls);
		}
		public function destroyPreLoader():void {
			if (loaderCls) {
				removeChild(loaderCls);
				loaderCls = null;
			}
		}
		
		/* Message Window */
		public function buildMsgWindow(xLoc:Number = 535 , yLoc:Number = 330):void {
			msgCls = new MsgWin();
			addChild(msgCls);
			msgCls.x = xLoc;
			msgCls.y = yLoc;
			TweenLite.from(msgCls, 1, {alpha:0  });
			TweenLite.to(msgCls, 1, {alpha:1});
		}
		public function destroyMsgWindow():void {
			if (msgCls) {
				removeChild(msgCls);
				msgCls = null;
			}
		}
		
		
		
		/* Debug Mode */
		public function debug():void {
			for (var i:uint = 0; i < this.numChildren; i++) {
				trace(i+'.\t name:' + this.getChildAt(i).name + '\t type:' + typeof (this.getChildAt(i))+ '\t' + this.getChildAt(i));
			}
		}
		
		/*
		public function remote_Config():void{
			var tempArr:Array = new Array(); 
			var obj:Object = new Object();
			obj.hostDomain  = "http://localhost/addoncars/";
			obj.gateWay     = "amfphp/gateway.php";
			obj.effected    = "assets/parts/effected-imgs/";
			obj.icons       = "assets/parts/icons/";
			obj.smallviews  = "assets/views/smallviews/";
			obj.canvesviews = "assets/views/canvesviews/";
			obj.backgrounds = "assets/backgrounds/";
			obj.uploadScript= "upload-assets.php";
			tempArr.push(obj);
			var str:String = JSON.encode(tempArr);
			trace(str);
		}
		*/
		
		


	}//$class
}//$package



/*
// Assign a value to a property of the parent

var theParent = MovieClip(this.parent);
theParent.someProperty = aValue;

// Call a method on the root (document class)
var theRoot = MovieClip(this.root);
theRoot.someMethod();




(add in class construtor)
addEventListener(Event.ADDED, added);
public function added(e:Event):void {
trace(parent); //works
}
*/