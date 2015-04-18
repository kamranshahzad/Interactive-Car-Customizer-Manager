package com.swap{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.controls.List;
	import com.adobe.serialization.json.JSON;

	import flash.net.NetConnection;
	import flash.net.Responder;

	import flash.display.Stage;
	import flash.text.*;
	import com.main.*;
	
	
	
	public class UIProcesser extends MovieClip {


		public var isExist:Boolean=false;


		public var setOfArr:Array;
		public var setTempArr:Array;

		public var pointer:Number=0;
		public var fieldValue:String='';
		public var prefix:String='SET';

		public var Container:MovieClip;
		public var partsIDArr:Array;
		public var partsLblArr:Array;

		public var allPartsLst:List;
		public var setPartLst:List;
		public var setElementLst:List;

		public var gateWay:String='';
		public var vehicle_id:Number=0;
		public var category_id:Number=0;

		
		public static var STAGE:Stage;
		public static var ROOT:MovieClip;

		public function UIProcesser( $category_id:Number , $vehicle_id:Number , $gateWay:String ):void {

			gateWay=$gateWay;
			vehicle_id=$vehicle_id;
			category_id=$category_id;


			Container = new MovieClip();
			addChild(Container);

			allPartsLst = new List();
			//allPartsLst.allowMultipleSelection=true;
			allPartsLst.setSize(200, 200);
			allPartsLst.move(30,185);
			Container.addChild(allPartsLst);


			setPartLst = new List();
			setPartLst.setSize(200, 200);
			setPartLst.move(300,185);
			Container.addChild(setPartLst);
			setPartLst.addEventListener(Event.CHANGE, updateSetLists);


			setElementLst = new List();
			//setElementLst.allowMultipleSelection=true;
			setElementLst.setSize(200, 200);
			setElementLst.move(570,185);
			Container.addChild(setElementLst);


			partsIDArr=new Array();
			partsLblArr=new Array();

			setOfArr = new Array();


			isSwapSetExist();
			
			STAGE = this.stage;
			//ROOT = this.root;
			
		}


		/*
		*********************************************************************************
		Message Window
		*/

		

		/*
		*********************************************************************************
		Remoting
		*/

		//# IsExist
		public function isSwapSetExist() {
			var myService = new NetConnection();
			myService.connect(gateWay);
			var responder=new Responder(is_swapset_exist,onFault);
			myService.call("AddOnCars.isSwapSetExist", responder , vehicle_id , category_id  );
		}
		function is_swapset_exist(rs:Object) {
			if (rs) {
				loadParts();
				isExist=true;
			} else {
				loadPartsBlank();
			}
		}

		//#Load All Parts
		public function loadPartsBlank() {
			var myService = new NetConnection();
			myService.connect(gateWay);
			var responder=new Responder(get_parts_blank,onFault);
			myService.call("AddOnCars.getPartBySwapper", responder , category_id , vehicle_id  );
		}
		public function get_parts_blank(rs:Object) {
			var count:Number=rs.serverInfo.totalCount;
			allPartsLst.removeAll();
			for (var i=0; i< count; i++) {
				partsIDArr.push(rs.serverInfo.initialData[i][0]);
				partsLblArr.push(rs.serverInfo.initialData[i][4]);
				allPartsLst.addItem({label:partsLblArr[i], data:partsIDArr[i]});
			}
		}

		public function loadParts() {
			var myService = new NetConnection();
			myService.connect(gateWay);
			var responder=new Responder(get_swap_parts,onFault);
			myService.call("AddOnCars.getPartBySwapper", responder , category_id , vehicle_id  );
		}
		public function get_swap_parts(rs:Object) {
			var count:Number=rs.serverInfo.totalCount;
			for (var i=0; i< count; i++) {
				partsIDArr.push(rs.serverInfo.initialData[i][0]);
				partsLblArr.push(rs.serverInfo.initialData[i][4]);
			}
			getSwapSet();
		}

		//#
		public function getSwapSet() {
			var myService = new NetConnection();
			myService.connect(gateWay);
			var responder=new Responder(get_swap_sets,onFault);
			myService.call("AddOnCars.getSwapSet", responder , category_id , vehicle_id  );
		}
		public function get_swap_sets(rs:Object) {
			var count:Number=rs.serverInfo.totalCount;
			fieldValue=rs.serverInfo.initialData[0][3];
			AIWorker();
		}


		//# Insert Swap Set
		function insertSwapSet($vehicle_id:Number , $category_id:Number , $swap_value:String ) {
			var myService = new NetConnection();
			myService.connect(gateWay);
			var responder=new Responder(insert_swapset_result,onFault);
			myService.call("AddOnCars.insertSwapSet", responder , $vehicle_id , $category_id , $swap_value  );
		}
		function insert_swapset_result(rs:Object) {
			trace("Insert:"+rs);
		}

		//# Update Swap Set
		function updateSwapSet($vehicle_id:Number , $category_id:Number , $swap_value:String ) {
			var myService = new NetConnection();
			myService.connect(gateWay);
			var responder=new Responder(update_swapset_result,onFault);
			myService.call("AddOnCars.updateSwapSet", responder , $vehicle_id , $category_id , $swap_value  );
		}
		function update_swapset_result(rs:Object) {
			trace("Update:"+rs);
		}

		//#Delete Swap Set
		function deleteSwapSet($vehicle_id:Number , $category_id:Number ) {
			var myService = new NetConnection();
			myService.connect(gateWay);
			var responder=new Responder(delete_swapset_result,onFault);
			myService.call("AddOnCars.deleteSwapSet", responder , $vehicle_id , $category_id  );
		}
		function delete_swapset_result(rs:Object) {
			trace("Delete:"+rs);
		}



		/*
		*********************************************************************************
		Parent Functions
		*/
		public function insertSet():void {
			insertSwapSet(vehicle_id , category_id , JSON.encode(setOfArr) );
		}

		public function updateSet():void {
			updateSwapSet(vehicle_id , category_id , JSON.encode(setOfArr) );
		}

		public function deleteSet( $vehicle_id:Number , $category_id:Number ):void {
			deleteSwapSet($vehicle_id , $category_id);
		}




		/*
		*********************************************************************************
		Searching ( UI )
		trace(findInSwapSets(5));
		*/

		public function findInSwapSets($key):Boolean {
			var parentArr:Array=JSON.decode(fieldValue);
			var temp:Boolean=false;
			for (var p:Number = 0; p < parentArr.length; p++) {
				for (var val:* in parentArr[p]) {
					for (var q:Number = 0; q < parentArr[p][val].length; q++) {
						if (parentArr[p][val][q].ID==$key) {
							getSwapSetItems(val);
							temp=true;
						}
					}
				}
			}
			return temp;
		}

		public function getSwapSetItems($setLabel:String):Array {
			var tempArr:Array = new Array();
			var parentArr:Array=JSON.decode(fieldValue);
			for (var p:Number = 0; p < parentArr.length; p++) {
				for (var val:* in parentArr[p]) {
					if (val==$setLabel) {
						for (var q:Number = 0; q < parentArr[p][val].length; q++) {
							tempArr.push(parentArr[p][val][q].ID);
						}
					}
				}
			}
			return tempArr;
		}

		/*
		*********************************************************************************
		Workers..
		*/

		public var freePartsArr:Array;
		public var groupedIdsArr:Array;
		public var setPostFixArr:Array;

		public function AIWorker():void {
			groupedIdsArr = new Array();
			freePartsArr  = new Array();
			setPostFixArr = new Array();
			groupedIdsArr=groupedPartIDs();

			allPartsLst.removeAll();
			setPartLst.removeAll();

			for (var i:Number = 0; i < partsIDArr.length; i++) {
				if (groupedIdsArr.indexOf(partsIDArr[i])==-1) {
					freePartsArr.push(partsIDArr[i]);
					allPartsLst.addItem({label:partsLblArr[i], data:partsIDArr[i]});
				}
			}

			setPostFixArr=getSetDetails();
			setSwapSetsPointer(setPostFixArr);


			// recycled
			var setObj:Object;
			var obj:Object;
			var idsArr:Array;

			var parentArr:Array=JSON.decode(fieldValue);
			for (var p:Number = 0; p < parentArr.length; p++) {
				for (var val:* in parentArr[p]) {
					setObj = new Object();
					idsArr = new Array();
					for (var q:Number = 0; q < parentArr[p][val].length; q++) {
						obj    = new Object();
						obj.ID=parentArr[p][val][q].ID;
						obj.LBL=parentArr[p][val][q].LBL;
						idsArr.push(obj);
					}
					setObj[val]=idsArr;
					setOfArr[p]=setObj;
					setPartLst.addItem({label:val,data:p});
				}
			}

			//trace(JSON.encode(setOfArr));
		}




		public function groupedPartIDs():Array {
			var groupedIdsArr:Array = new Array();
			var parentArr:Array=JSON.decode(fieldValue);
			for (var p:Number = 0; p < parentArr.length; p++) {
				for (var val:* in parentArr[p]) {
					for (var q:Number = 0; q < parentArr[p][val].length; q++) {
						groupedIdsArr.push(parentArr[p][val][q].ID);
					}
				}
			}
			return groupedIdsArr;
		}

		public function getSetDetails():Array {
			var parentArr:Array=JSON.decode(fieldValue);
			for (var i:int=0; i<parentArr.length; i++) {
				var k:Object=parentArr[i];
				for (var s:Object in k) {
					setPostFixArr.push(s.substr(3,s.length));
				}
			}
			return setPostFixArr;
		}

		public function setSwapSetsPointer(setIndex:Array):void {
			var temp:Number=setIndex[setIndex.length-1];
			pointer=temp+1;
		}




		/*
		***********************************************************************************************
		#1
		*/
		public function createSet():void {
			if (allPartsLst.selectedIndex>-1) {
				var setObj:Object = new Object();
				var idsArr:Array = new Array();

				var obj:Object = new Object();
				obj.ID=allPartsLst.getItemAt(allPartsLst.selectedIndex).data;
				obj.LBL=allPartsLst.getItemAt(allPartsLst.selectedIndex).label;
				allPartsLst.removeItemAt(allPartsLst.selectedIndex);
				idsArr.push(obj);
				setObj["SET"+pointer]=idsArr;
				setOfArr[pointer]=setObj;
				setPartLst.addItem({label:"SET" + pointer , data:pointer});
				pointer++;
			} else {
				trace("Please Select Item to create Set");
			}
		}

		public function insertElementInSet():void {

			if (allPartsLst.selectedIndex>-1&&setPartLst.selectedIndex>-1) {
				var $set:String=setPartLst.selectedItem.label;
				var $data:Number=setPartLst.selectedItem.data;

				var tmpIdArr:Array  = new Array();
				var tmpLblArr:Array = new Array();
				var tempArr:Array = new Array();
				var obj:Object = new Object();
				obj=setOfArr[$data];
				tempArr=obj[$set];


				tmpIdArr.push(allPartsLst.selectedItem.data);
				tmpLblArr.push(allPartsLst.selectedItem.label);

				for (var p:Number = 0; p < tempArr.length; p++) {
					tmpIdArr.push(tempArr[p].ID);
					tmpLblArr.push(tempArr[p].LBL);
				}

				var setObj:Object = new Object();
				var idsArr:Array = new Array();
				for (var q:Number = 0; q < tmpIdArr.length; q++) {
					var ob:Object = new Object();
					ob.ID=tmpIdArr[q];
					ob.LBL=tmpLblArr[q];
					idsArr.push(ob);
				}
				allPartsLst.removeItemAt(allPartsLst.selectedIndex);
				setObj[$set]=idsArr;
				setOfArr[$data]=setObj;

				populateSetElements($set , $data);
			} else {
				trace("Please Select Element and Set");
			}
		}


		public function removeElementFromSet():void {
			if (setElementLst.selectedIndex>-1) {
				var $filter:Number=setElementLst.selectedItem.data;
				var delID:Number=0;
				var delLbl:String='';

				var $set:String=setPartLst.selectedItem.label;
				var $data:Number=Number(setPartLst.selectedItem.data);

				var tmpIdArr:Array  = new Array();
				var tmpLblArr:Array = new Array();
				var tempArr:Array = new Array();
				var obj:Object = new Object();
				obj=setOfArr[$data];
				tempArr=obj[$set];

				for (var p:Number = 0; p < tempArr.length; p++) {
					tmpIdArr.push(tempArr[p].ID);
					tmpLblArr.push(tempArr[p].LBL);
				}

				var setObj:Object = new Object();
				var idsArr:Array = new Array();
				for (var q:Number = 0; q < tmpIdArr.length; q++) {
					var ob:Object = new Object();
					if ($filter!=tmpIdArr[q]) {
						ob.ID=tmpIdArr[q];
						ob.LBL=tmpLblArr[q];
						idsArr.push(ob);
					} else {
						delID=tmpIdArr[q];
						delLbl=tmpLblArr[q];
					}
				}
				setElementLst.removeItemAt(setElementLst.selectedIndex);
				allPartsLst.addItem({label:delLbl,data:delID});
				setObj[$set]=idsArr;
				setOfArr[$data]=setObj;

				populateSetElements($set , $data);
			} else {
				trace("Select Set Element to Remove");
			}
		}

		public function removeSet():void {

			if (setPartLst.selectedIndex>-1) {
				var $set:String=setPartLst.selectedItem.label;
				var $data:Number=Number(setPartLst.selectedItem.data);

				var tmpIdArr:Array  = new Array();
				var tmpLblArr:Array = new Array();
				var tempArr:Array = new Array();
				var obj:Object = new Object();
				obj=setOfArr[$data];
				tempArr=obj[$set];

				for (var p:Number = 0; p < tempArr.length; p++) {
					tmpIdArr.push(tempArr[p].ID);
					tmpLblArr.push(tempArr[p].LBL);
				}

				delete setOfArr[$data]
				;
				for (var q:Number = 0; q < tmpIdArr.length; q++) {
					allPartsLst.addItem({label:tmpLblArr[q],data:tmpIdArr[q]});
				}
				updateSetList();
			} else {
				trace("Please Sets List");
			}
		}

		public function updateSetList():void {
			setPartLst.removeAll();
			setElementLst.removeAll();

			for (var p:Number = 0; p < setOfArr.length; p++) {
				for (var val:* in setOfArr[p]) {
					var num:Number=val.substring(3,val.length);
					setPartLst.addItem({label:val , data:num});
				}
			}
		}


		public function getSets():void {
			for (var p:Number = 0; p < setOfArr.length; p++) {
				for (var val:* in setOfArr[p]) {
					trace( val + " : "+setOfArr[p][val][0].ID + ' ===> '+ setOfArr[p][val][0].LBL);
				}
			}
		}



		private function updateSetLists(e:Event):void {
			populateSetElements(setPartLst.selectedItem.label , Number(setPartLst.selectedItem.data));
		}


		public function populateSetElements($set:String , $data:Number):void {
			setElementLst.removeAll();
			var tempArr:Array = new Array();
			var obj:Object = new Object();
			obj=setOfArr[$data];
			tempArr=obj[$set];
			for (var p:Number = 0; p < tempArr.length; p++) {
				setElementLst.addItem({label:tempArr[p].LBL, data:tempArr[p].ID});
			}
		}


		public function resetAll():void {
			setElementLst.removeAll();
		}

		public function Save():void {
			trace(JSON.encode(setOfArr));
		}



		/*
		*******************************************************************************************
		_get helper functions
		*/


		/*
		public function refineSwapper(rawString:String):void{
		var setObj:Object;
		var obj:Object;
		var idsArr:Array;
		var parentArr:Array=JSON.decode(rawString);
		for (var p:Number = 0; p < parentArr.length; p++) {
		for (var val:* in parentArr[p]) {
		setObj = new Object();
		idsArr = new Array();
		for (var q:Number = 0; q < parentArr[p][val].length; q++) {
		obj    = new Object();
		obj.ID  = parentArr[p][val][q].ID;
		obj.LBL = parentArr[p][val][q].LBL;
		idsArr.push(obj);
		}
		if(idsArr[p] != undefined){
		setObj[val] = idsArr;
		setOfArr.push(setObj);
		}
		}
		}
		trace("Refined==> "+JSON.encode(setOfArr));
		}
		*/


		public function detectEmpty():Boolean {
			var empty:Boolean=false;
			var selectedIndexArr:Array=allPartsLst.selectedIndices;
			for (var p:Number = 0; p < selectedIndexArr.length; p++) {
				if (allPartsLst.getItemAt(selectedIndexArr[p]).data!='none') {
					empty=true;
				}
			}
			return empty;
		}

		public function removeEmpty():void {
			for (var p:Number = 0; p < allPartsLst.length; p++) {
				if (allPartsLst.getItemAt(p).data=='none') {
					allPartsLst.removeItemAt(p);
				}
			}
		}

		public function getSelectedItems():void {
			var selectedItemsArr:Array=allPartsLst.selectedItems;
			for (var p:Number = 0; p < selectedItemsArr.length; p++) {
				trace(selectedItemsArr[p].data);//  label
			}
		}





		/*
		private function removeSelected(selectedItems:Array):Array
		{
		    var returnArray:Array = []
		    for each(var object:Object in this.arrayQueue)
		    {
		        if( selectedItems.indexOf(object)==-1 )
		                returnArray.push( object )
		    }
		    return returnArray;
		}
		
		private function traceObject(o:Object):void {
		for (var val:* in o) {
		trace('['  + val + ' ] ');
		}
		//trace(setOfArr[0].SET0[0].ID);
		//trace(setOfArr[p][val][0].ID);
		}
		
		
		public function ParseObject(obj:Object , p:Number):void{
		for (var val:* in obj) {
		trace(setOfArr[p][val].length);
		}
		}
		
		
		
		function fRemoveDup(ac:Array) : void
		{
		    var i, j : int;
		    for (i = 0; i < ac.length - 1; i++)
		        for (j = i + 1; j < ac.length; j++)
		            if (ac[i] === ac[j])
		                ac.splice(j, 1);
		}
		*/


		function onFault(f:Event ) {
			trace("There was a problem");
		}



	}// $class
}// $package