/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.util.List;
import java.util.Map;
import javax.ejb.Local;
import pakket.UrsGebruiker;
import pakket.UrsKlas;
import pakket.UrsStudent;
import pakket.UrsStudentrelatie;

/**
 *
 * @author witmoca
 */
@Local
public interface docentBeanLocal {
    // KLAS
    public List<UrsKlas> getKlasLijst();
    public Map<UrsKlas, Integer> getKlasLijstMetWarnings();
    public UrsKlas getKlas(int klasid);
    public void addKlas(String klasNaam);
    public void removeKlas(int klasId);
    public int changeKlasNaam(int klasId, String nieuweNaam);
    
    // STUDENTEN IN KLAS
    public List<UrsStudent> getStudentenInKlas(int klasId);
    public Map<UrsStudent,Integer> getErroredStudentenInKlas(int klasId);
    public Map<UrsGebruiker, Integer> getKlaslozeStudentenVoorkeur(int klasId);
    public void setStudentKlas(int userId, int klasId);
    public List<UrsStudentrelatie> getViolatedRelaties(int klasId);
    public List<RelatieWrapper> wrapRelaties(List<UrsStudentrelatie> li);
    
    // STATUS
    public void eindeKeuzes();
    public int aantalToegewezenStudenten();
    public int aantalStudenten(); 
    public int bevestigen();
    public int aantalBevestigdeStudenten();
    public int aantalOnbevestigeStudenten();
    
    public int bevestigd();

    public int periodeGestopt();

    public List<UrsGebruiker> getUsers();

    public void setAdminMessage(String message);
    
}
