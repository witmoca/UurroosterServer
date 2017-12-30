<%-- 
    Document   : docent
    Created on : Nov 29, 2017, 4:01:56 PM
    Author     : Matthias Wens
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
        <title>Docent</title>
    </head>
    <body>
        <div class="header">
            <h1>Docentenportaal <c:out value="${sessionScope['docentnaam']}" /></h1>
        </div>
        <c:if test="${sessionScope['bevestigd'] != 0 && sessionScope['periodeGestopt'] != 0}">
            <form method="post" action="<% out.println(response.encodeURL("")); %>">
                <input type="hidden" name="stage" value="eindeKeuzes">
                <button type="submit" class="verwijderen">Keuzetermijn studenten afsluiten</button>
            </form>
        </c:if>
        <br/>
        <c:if test="${sessionScope['bevestigd'] != 0}">
            <form method="post" action="<% out.println(response.encodeURL("")); %>">
                <input type="text" name="nieuweGroepNaam">
                <input type="hidden" name="stage" value="voegGroepToe">
                <button type="submit">Groep toevoegen +</button>
            </form>
        </c:if>
            
            
        <table>
            <tr>
                <th>Klassen</th>
            </tr>     
            <c:forEach var="i" items="${sessionScope['klassen']}">
                <tr>
                    <td><c:out value='${i.key.getNaam()}'/></td>
                    <c:if test="${sessionScope['bevestigd'] != 0}">
                        <td>
                            <form method="post" action="<% out.println(response.encodeURL("docent.do")); %>">
                                <input type="hidden" name="stage" value="verwijderen">
                                <input type="hidden" name="verwijderKlas" value="${i.key.getKlasid()}">
                                <button class="verwijderen" type="submit">X</button>
                            </form>
                        </td>
                    </c:if>
                    <td>
			<form method="post" action="<% out.println(response.encodeURL("docent.do")); %>">
			    <input type="hidden" name="stage" value="edit">
			    <input type="hidden" name="editKlas" value="${i.key.getKlasid()}">
                            <c:if test="${sessionScope['bevestigd'] != 0}">
                                <button class="edit" type="submit">Edit</button>
                            </c:if>
                            <c:if test="${sessionScope['bevestigd'] == 0}">
                                <button class="edit" type="submit">View</button>
                            </c:if>
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
        <div class="progress">
            <p style="font-weight: bold;">Toegewezen:</p>
            <div class="container">
                <div style="width: <%=request.getAttribute("aantalToegewezenStudenten") %>%" class="afgewerkt"><%=request.getAttribute("aantalToegewezenStudenten") %>%</div>
            </div>    
        </div>
        <div class="knopjes">
            <c:if test="${sessionScope['bevestigd'] != 0}">
                <form method="post" action="<% out.println(response.encodeURL("")); %>">
                    <input type="hidden" name="stage" value="bevestigen">
                    <c:if test="${sessionScope['alert'] == 1}">
                        <p style="font-weight: bold; color: red;">BEVESTIGEN NOG NIET MOGELIJK!</p>
                    </c:if>
                    <button type="submit">Bevestigen</button>
                </form>
            </c:if>
            <form method="post" action="<% out.println(response.encodeURL("common/logout.jsp")); %>">
                <input type="hidden" name="stage" value="afmelden">
                <button type="submit">Afmelden</button>
            </form>
        </div>
    </body>
</html>
