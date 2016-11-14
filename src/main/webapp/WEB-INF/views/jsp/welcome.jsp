<%@page session="false" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<html lang="en">
<head>
    <spring:url value="/resources/core/js/jquery.1.10.2.min.js"
                var="jqueryJs"/>
    <script src="${jqueryJs}"></script>
</head>
<body>
<div class="container" style="min-height: 500px">
    <div class="starter-template">
        <div id="feedback"></div>
        <form class="form-horizontal" id="search-form">
            <div class="form-group form-group-lg">
                <label class="col-sm-2 control-label">USERNAME</label>
                <div class="col-sm-10">
                    <input type=text class="form-control" id="username">
                </div>
            </div>
            <div class="form-group form-group-lg">
                <label class="col-sm-2 control-label">EMAIL</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="email">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" id="bth-search"
                            class="btn btn-primary btn-lg">SEARCH
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    jQuery(document).ready(function ($) {

        $("#search-form").submit(function (event) {

            // Disble the search button
            enableSearchButton(false);

            // Prevent the form from submitting via the browser.
            event.preventDefault();

            searchViaAjax();

        });

    });

    function searchViaAjax() {

        var search = {}
        search["username"] = $("#username").val();
        search["email"] = $("#email").val();

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "${home}search/api/getSearchResult",
            data: JSON.stringify(search),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                console.log("SUCCESS: ", data);
                display(data);
            },
            error: function (e) {
                console.log("ERROR: ", e);
                display(e);
            },
            done: function (e) {
                console.log("DONE");
                enableSearchButton(true);
            }
        });

    }

    function enableSearchButton(flag) {
        $("#btn-search").prop("disabled", flag);
    }

    function display(data) {
        var json = "<h4>Ajax Response</h4><pre>"
                + JSON.stringify(data, null, 4) + "</pre>";
        $('#feedback').html(json);
    }
</script>

</body>
</html>