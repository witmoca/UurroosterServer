<%-- 
    Document   : groepen
    Created on : 28-nov-2017, 11:17:27
    Author     : student
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
        <title><c:out value="${sessionScope['klasnaam']}" /></title>
        <script>
        function myFunction() {
          // Declare variables 
          var input, filter, table, tr, td, i;
          input = document.getElementById("myInput");
          filter = input.value.toUpperCase();
          table = document.getElementById("myTable");
          tr = table.getElementsByTagName("tr");

          // Loop through all table rows, and hide those who don't match the search query
          for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0];
            if (td) {
              if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
              } else {
                tr[i].style.display = "none";
              }
            } 
          }
        }
        </script>
    </head>
    <body>
        <div class="header">
            <h1><c:out value="${sessionScope['klasnaam']}" />
                <c:if test="${sessionScope['klasTotaalErrors'] != 0}">
                    - <c:out value="${sessionScope['klasTotaalErrors']}"/> errors &#9888;
                </c:if>
            </h1>
        </div>
        <div id="klasgroep">
        <h2>Studenten in klasgroep</h2>
        <table>
            <c:forEach var="i" items="${sessionScope['klas']}">
                <tr>
                    <td><c:out value='${i.key.getUrsGebruiker().getNaam()}'/></td>
                    <td>
			<form method="post" action="<% out.println(response.encodeURL("docent.do")); %>">
			    <input type="hidden" name="stage" value="verwijderenStudent">
			    <input type="hidden" name="verwijderStudent" value="${i.key.getUserid()}">
			    <button class="verwijderen" type="submit">X</button>
			</form>
		    </td>
                    <c:if test="${i.value != 0}">
                        <td>
                            <c:out value='${i.value}'/> errors &#9888;
                        </td>
                    </c:if>
                </tr> 
            </c:forEach>
        </table>
        </div>
        <div id="overigeStudenten">
            <h2>Overige Studenten</h2>
            <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for names..">

            <table id="myTable">
                <c:forEach var="i" items="${sessionScope['overige']}">
                    <c:if test="${i.value == 1}">
                        <tr style="background-color: green">
                            <form id="overigeStudenten" method="post" action="<% out.println(response.encodeURL("docent.do")); %>">
                                <input type="hidden" name="SelectedStudent" value="<c:out value='${i.key.getNaam()}'/>">
                                <input type="hidden" name="stage" value="voegtoeStudent">
                                <td>
                                    ${i.key.getNaam()}
                                </td>
                                <td>
                                    <button type="submit" class="toevoegen">V</button>
                                </td>
                            </form>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:forEach var="i" items="${sessionScope['overige']}">
                    <c:if test="${i.value == 0}">
                        <tr>
                            <form id="overigeStudenten" method="post" action="<% out.println(response.encodeURL("docent.do")); %>">
                                <input type="hidden" name="SelectedStudent" value="<c:out value='${i.key.getNaam()}'/>">
                                <input type="hidden" name="stage" value="voegtoeStudent">
                                <td>
                                    ${i.key.getNaam()}
                                </td>
                                <td>
                                    <button type="submit" class="toevoegen">V</button>
                                </td>
                            </form>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:forEach var="i" items="${sessionScope['overige']}">
                    <c:if test="${i.value == 2}">
                        <tr  style="background-color: red">
                            <form id="overigeStudenten" method="post" action="<% out.println(response.encodeURL("docent.do")); %>">
                                <input type="hidden" name="SelectedStudent" value="<c:out value='${i.key.getNaam()}'/>">
                                <input type="hidden" name="stage" value="voegtoeStudent">
                                <td>
                                    ${i.key.getNaam()}
                                </td>
                                <td>
                                    <button type="submit" class="toevoegen">V</button>
                                </td>
                            </form>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
        <div id="relatieErrors">
            <h2>Errors:</h2>
            <table>
                <tr><th>Student 1</th><th>Student 2</th></tr>
                <c:forEach var="i" items="${sessionScope['errors']}">
                    <tr <c:if test="${i.getRELATIE() == 1}"> style="background-color: green"</c:if><c:if test="${i.getRELATIE() == 2}"> style="background-color: red"</c:if>>
                        <td><c:out value='${i.getSTUDENT_NAAM_1()}' /></td>
                        <td><c:out value='${i.getSTUDENT_NAAM_2()}' /></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="knopjes">
            <form method="post" action="<% out.println(response.encodeURL("docent.do")); %>">
                <input type="hidden" name="stage" value="null">
                <button class="terug" type="submit">Terug</button>
            </form>
            <form method="post" action="<% out.println(response.encodeURL("common/logout.jsp")); %>">
                <input type="hidden" name="stage" value="afmelden">
                <button type="submit">Afmelden</button>
            </form>
        </div>
    </body>
</html>
