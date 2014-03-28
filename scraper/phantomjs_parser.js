var page = require('webpage').create();

page.onConsoleMessage = function(msg) {
    console.log(msg);
};

// console.log(phantom.args[0])

page.open(phantom.args[0], function(status) { 
    if ( status === "success") {
        console.log("success!");
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
        console.log("fail!");
        phantom.exit()
    }
});
