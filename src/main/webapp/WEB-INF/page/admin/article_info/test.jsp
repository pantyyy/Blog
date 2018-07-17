
<!DOCTYPE html>
<html>
<head>
    <title>Markdown.js</title>
    <script type="text/javascript" src="/blog/static/markdown/showdown-master/dist/showdown.min.js"></script>
</head>
<style>

</style>
<body>
<div>
 
    <textarea id="oriContent" style="height:400px;width:600px;" onkeyup="convert()"></textarea>
 
    <div id="result"></div>
 
</div>
 
<script type="text/javascript">
 function convert(){
    var text = document.getElementById("oriContent").value;
    var converter = new showdown.Converter();
    var html = converter.makeHtml(text);
    document.getElementById("result").innerHTML = html;
}

/* function compile(){
    var text = document.getElementById("oriContent").value;
    var converter = new showdown.Converter();
    var html = converter.makeHtml(text);
    document.getElementById("result").innerHTML = html;
} */
</script>
</body>
</html>