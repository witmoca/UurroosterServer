/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pakket;

import beans.commonBeanLocal;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author witmoca
 */
public class docent extends HttpServlet {
    @EJB
    private commonBeanLocal commonBean;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String gotop = "/student/student.jsp";
        
        int userId = commonBean.getUserId(request.getUserPrincipal().getName());
        if(userId == -1)
            gotoPage("Error.jsp", request, response);
        HttpSession sessie = request.getSession();   
        List<UrsKlas> klassen = commonBean.getKlasLijst();
        sessie.setAttribute("klassen", klassen);
        String stage = request.getParameter("stage");
        if(stage == null)
            gotoPage("/docent/docent.jsp",request, response);
        else switch (stage) {
            case "verwijderen":
                commonBean.removeKlas(Integer.parseInt(request.getParameter("verwijderKlas")));
                klassen = commonBean.getKlasLijst();
                sessie.setAttribute("klassen", klassen);
                gotoPage("/docent/docent.jsp",request, response);
                break;
            case "voegGroepToe":
                commonBean.addKlas();
                klassen = commonBean.getKlasLijst();
                sessie.setAttribute("klassen", klassen);
                gotoPage("/docent/docent.jsp",request, response);
                break;
            case "bevestigen":
                gotoPage("/docent/docent.jsp",request, response);
                break;    
            default:
                gotoPage("/docent/docent.jsp",request, response);
                break;
        }
    }
    
    public void gotoPage(String jsp, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        RequestDispatcher view = request.getRequestDispatcher(jsp);
        view.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
