<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html lang="en">
    <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Kobold Camp</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/img/koboldicon.png" rel="shortcut icon">
        <link href="${pageContext.request.contextPath}/css/forms.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/jquery.vegas.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Ruluko' rel='stylesheet' type='text/css' />
    </head>
    <body>
        <div id="wrapper">
            <!-- Navigation -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <!--     <a class="navbar-brand" href="img/4.jpg"></a> -->
                    </div>
                    <!-- Collect the nav links for toggling -->
                    <div class="collapse navbar-collapse navbar-ex1-collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="${pageContext.request.contextPath}/mainAjaxPage">HOME</a></li>
                            <li><a href="${pageContext.request.contextPath}/rentals">RENTALS</a></li>
                                <sec:authorize access="hasRole('ROLE_EMPLOYEE')">
                                <li><a href="${pageContext.request.contextPath}/asset">ASSETS</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_EMPLOYEE')">
                                <li><a href="${pageContext.request.contextPath}/members">MEMBERS</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <li><a href="${pageContext.request.contextPath}/admin">ADMIN</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_USER')">
                                <li><a href="${pageContext.request.contextPath}/profile">PROFILE</a></li>
                                </sec:authorize>
                            <li role="presentation">
                                <a id ="logInUsername"><sec:authentication property="principal.username" /></a>
                            </li>
                            <li role="presentation">
                                <a href="${pageContext.request.contextPath}/j_spring_security_logout">LOG OUT</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container" style="PADDING-TOP: 75px">
                <div>
                    <h2>Search</h2>
                    <form class="form-horizontal" role="form">
                        <table id="SearchTable" class="table table-hover">
                            <tr>
                            <div>
                                <label class="" for=""></label><input style="width: 150px;" type="text" placeholder="Asset Tag">
                                <label class="" for=""></label><input style="width: 150px;" type="text" placeholder="Category">
                                <label class="" for=""></label><input style="width: 150px;" type="text" placeholder="Description">
                                <label class="" for=""></label><input style="width: 150px;" type="text" placeholder="Status">
                                <label class="" for=""></label><input style="width: 150px;" type="text" placeholder="Member">
                                <label><button type="submit" id="search-button" class="btn btn-default">Search</button></label>
                            </div>                           
                            </tr>
                        </table>
                    </form>
                </div> 
            </div>

            <div class="container">
                <div>
                    <div class="row">
                        <table id="AssetTable" class="table table-hover">
                            <tr>
                                <th width="8%">Asset Tag</th>
                                <th width="10%">Category</th>
                                <th width="10%">Brand</th>
                                <th width="20%">Description</th>
                                <th width="12%">Status</th>
                                <th width="10%">Member</th>
                                <th width="10%"></th>
                                <th width="10%">History</th>
                                <th width="10%">Check In/Out</th>
                            </tr>
                            <tbody id="assetRows"></tbody>
                        </table>
                    </div> 
                </div>
            </div>

            <!-- View History Modal -->
            <div class="modal fade" id="viewHistoryModal" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="detailsModalLabel">Rental History</h4>
                        </div>
                        <div class="modal-body">
                            <div class="container">
                                <div class="col-md-9">
                                    <div class="row">
                                        <table id="historyTable" class="table table-hover">
                                            <tr>
                                                <th width="10%">Date</th>
                                                <th width="20%">Employee</th>
                                                <th width="20%">Status</th>
                                                <th width="25%">Member Name</th>
                                                <th width="40%">Notes</th>
                                            </tr>
                                            <tbody id="historyRows"></tbody>
                                        </table>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- checkIn Modal -->
            <div class="modal fade" id="checkInModal" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form class="form-labels-on-top" method="post" action="#">
                            <div class="form-title-row">
                                <h1>Equipment Tag #: </h1><h4><div id="equipmentStatus"> </div></h4>
                            </div>
                            <div class="form-row">
                                <input type="text" id="updateAssetMemberId" placeholder="Member ID">
                            </div>
                            <div class="form-row">
                                <label>
                                    <select id="assetStatusTable">
                                        <option value="" disabled selected>Select Status Here</option> 
                                        <option value="2">Checked Out</option>
                                        <option value="1">Available</option>
                                        <option value="4">Lost</option>
                                        <option value="3">Broken</option>
                                        <option value="5">In for Repairs</option>
                                    </select>
                                </label>
                            </div>
                            <div class="form-row">
                                <textarea rows="4" cols="30" id="xtraNotes" placeholder="Extra Notes"></textarea>
                            </div>
                            <div class="form-row">
                                <button type="submit" id="editAsset">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

<!--            <div class="for-full-back " id="footer">
                2016 www.koboldcamp.com | All Right Reserved
            </div>-->
            <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>    
            <script src="${pageContext.request.contextPath}/js/kobold.js"></script>
        </div>
    </body>
</html>
