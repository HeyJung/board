console.log("cmt module....");

var cmtService = (function(){
	
	function add(cmt, callback, error){
		console.log("add cmt....");
		
		$.ajax({
			type: 'post',
			url: '/cmt/new',
			data: JSON.stringify(cmt),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error){
		var board_id = param.board_id;
		var page = param.page || 1;
		
		$.getJSON("/cmt/pages/"+board_id+"/"+page+".json",
				function(data){
					if(callback){
						callback(data);
					}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	function remove(id, callback, error){
		$.ajax({
			type: 'delete',
			url: '/cmt/'+id,
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function update(cmt, callback, error){
		console.log("id : "+cmt.id);
		
		$.ajax({
			type: 'put',
			url: '/cmt/'+cmt.id,
			data: JSON.stringify(cmt),
			contentType: 'application/json; charset=utf-8',
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function get(id, callback, error){
		$.get("/cmt/"+id+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(err);
			}
		});
	}
	
	function displayTime(timeValue){
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		
		var str = "";
		if(gap < (1000*60*60*24)){
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [yy, '/', (mm>9?'':'0') + mm, '/', (dd>9?'':'0') + dd, ' ',
				(hh>9?'':'0') + hh, ':', (mi>9?'':'0') + mi, ':', (ss>9?'':'0') + ss].join('');
		} else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm>9?'':'0') + mm, '/', (dd>9?'':'0') + dd].join('');
		}
	}
	
	return{
		add : add,
		getList : getList,
		remove: remove,
		update: update,
		get:get,
		displayTime : displayTime
	};
})();