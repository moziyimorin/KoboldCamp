<%-- 
    Document   : login
    Created on : Jan 13, 2016, 3:09:01 PM
    Author     : apprentice
--%>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kobold Camp</title>
        <link href="${pageContext.request.contextPath}/css/forms.css" rel="stylesheet">
    </head>
    <body>
        <div>
            <h2>Sign in</h2>
            <!-- #1 - If login_error == 1 then there was a failed login
           attempt -->
            <!-- so display an error message
            -->
            <c:if test="${param.login_error == 1}">
                <h3>Wrong id or password!</h3>
            </c:if>
            <!-- #2 - Post to Spring security to check our authentication -->
            <form method="post" class="signin"
                  action="j_spring_security_check">
                <fieldset>
                    <table cellspacing="0">
                        <tr>
                            <th>
                                <label for="username">Username
                                </label>
                            </th>

                            <td><input id="username_or_email"
                                       name="j_username"
                                       type="text" />
                            </td>
                        </tr>
                        <tr>
                            <th><label for="password">Password</label></th>
                            <!-- #2b - must be j_password for Spring -->
                            <td><input id="password"
                                       name="j_password"
                                       type="password" />
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td><input name="commit" type="submit"
                                       value="Sign In" /></td>
                        </tr>
                    </table>
                </fieldset>
            </form>
        </div>
        
        <!-- placed at the end of the document so that the pages load faster -->
        <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    </body>
</html>
