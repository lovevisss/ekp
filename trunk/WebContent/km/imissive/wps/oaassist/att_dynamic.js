function getHost(){
    var host = location.protocol.toLowerCase()+"//" + location.hostname;
    if(location.port!='' && location.port!='80'){
        host = host+ ":" + location.port;
    }
    return host;
}

function insertRedHead(url, bookmark,book1)
{
    //获取这个文档
    var doc = wpsLinuxPluginObj.ActiveDocument;
    //获取这个文档的所有书签
    var bookMarks = doc.Bookmarks;
    var selection = wpsLinuxPluginObj.ActiveWindow.Selection;
    // 准备以非批注的模式插入红头文件(剪切/粘贴等操作会留有痕迹,故先关闭修订)
    doc.TrackRevisions = false;
    selection.WholeStory(); //选取全文
    selection.Cut();
    selection.InsertFile(url); //套红模板url
	// 轮询插入书签
	if(bookmark!="redhead"){
		for (var key in bookmark) {
			var bookVal = bookmark[key];
			if(bookVal=="redhead"){
				var book_s= bookMarks.Item(bookVal);
				book_s.Range.Select(); //获取指定书签位置
				var s = wpsLinuxPluginObj.ActiveWindow.Selection;
				s.Paste();
			}else{
				var valLeng = bookmark.indexOf(bookVal);
				if("-1" != valLeng){
					var book_ss= bookMarks.Item(bookVal);
					if(book_ss!=null && book_ss!=undefined){
						let bookStart = book_ss.Range.Start;
						let bookEnd = book_ss.Range.End;
						let start = doc.Range().End;
						if(book1[bookVal]!=null && book1[bookVal]!=undefined){
							book_ss.Range.Text=book1[bookVal];
						}
						let end = doc.Range().End;
						if (!bookMarks.Exists(bookVal)){
							var book=bookMarks.Add(bookVal,doc.Range(0,0));
							book.Start=bookStart;
							book.End= bookEnd + (end - start);
						}
					}
				}
			}
		}
	}else{
		var bookRedhead= bookMarks.Item("redhead");
		bookRedhead.Range.Select(); //获取指定书签位置
		var ss = wpsLinuxPluginObj.ActiveWindow.Selection;
		ss.Paste();
	}
}