//this file is for phantomjs
//return the document element that have already been analysed

var page = require('webpage').create();
// console.log('The default user agent is ' + page.settings.userAgent);
page.settings.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.149 Safari/537.36';

page.onConsoleMessage = function(msg) {
    console.log(msg);
};

page.open(phantom.args[0], function(status) { 
    if ( status === "success") {
        //console.log("success!");
        page.includeJs("http://code.jquery.com/jquery-1.11.0.min.js", function() {
            page.evaluate(function() {
                // $(".s_microblog").each(function(index){
                //     console.log("[s_microblog"+index+"] "+$(this).html());
                // });
                console.log(document.documentElement.innerHTML); 
            });
            phantom.exit();
        });
    }
    else{
        //console.log("fail!");
        phantom.exit()
    }
});
