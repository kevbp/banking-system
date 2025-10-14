package entidad;

import java.math.BigDecimal;
import java.sql.Date; // Para mapear fechas de la BD
import java.sql.Time;
import java.sql.Timestamp;

public class Cuenta {
    // 1. Campos principales de t_cuentas
    private String numCuenta;
    private String codCliente;
    private String codTipoCuenta;
    private String codMoneda;
    private BigDecimal salAct; // CLAVE: Usar BigDecimal para el saldo
    private Timestamp fecApe;
    private Timestamp fecCie;
    private Timestamp fecUltMov;
    private BigDecimal salIni;
    private String cci;
    private String codEstado;

    // 2. Campos de auditoría
    private String codUsuCre;
    private Timestamp fecUsuCre;
    private String codUsuMod;
    private Timestamp fecUsuMod;
    
    // 3. Objetos de relación y descripciones (para JOINs)
    private Cliente cliente; // Objeto Cliente asociado (Requiere setter)
    private String desTipoCuenta; 
    private String desMoneda;     
    private String desEstado;     
    
    // --- Constructor vacío (Requerido para el DAO) ---
    public Cuenta() {}
    
    // --- GETTERS & SETTERS (CORREGIDOS Y COMPLETADOS) ---

    public String getNumCuenta() { 
        return numCuenta; 
    }
    
    public void setNumCuenta(String numCuenta) { 
        this.numCuenta = numCuenta; 
    }

    public String getCodCliente() { 
        return codCliente; 
    }
    
    public void setCodCliente(String codCliente) { 
        this.codCliente = codCliente; 
    }

    public String getCodTipoCuenta() { 
        return codTipoCuenta; 
    }
    
    public void setCodTipoCuenta(String codTipoCuenta) { 
        this.codTipoCuenta = codTipoCuenta; 
    }

    public String getCodMoneda() { 
        return codMoneda; 
    }
    
    public void setCodMoneda(String codMoneda) { 
        this.codMoneda = codMoneda; 
    }

    // SETTER CLAVE: Para asignar el saldo con precisión
    public BigDecimal getSalAct() { 
        return salAct; 
    }
    
    public void setSalAct(BigDecimal salAct) { 
        this.salAct = salAct; 
    }

    public Timestamp getFecApe() { 
        return fecApe; 
    }
    
    public void setFecApe(Timestamp fecApe) { 
        this.fecApe = fecApe; 
    }
    
    public Timestamp getFecCie() { 
        return fecCie; 
    }
    
    public void setFecCie(Timestamp fecCie) { 
        this.fecCie = fecCie; 
    }

    public Timestamp getFecUltMov() { 
        return fecUltMov; 
    }
    
    public void setFecUltMov(Timestamp fecUltMov) { 
        this.fecUltMov = fecUltMov; 
    }

    public BigDecimal getSalIni() { 
        return salIni; 
    }
    
    public void setSalIni(BigDecimal salIni) { 
        this.salIni = salIni; 
    }

    public String getCci() { 
        return cci; 
    }
    
    public void setCci(String cci) { 
        this.cci = cci; 
    }
    
    public String getCodEstado() { 
        return codEstado; 
    }
    
    public void setCodEstado(String codEstado) { 
        this.codEstado = codEstado; 
    }

    public String getCodUsuCre() { 
        return codUsuCre; 
    }
    
    public void setCodUsuCre(String codUsuCre) { 
        this.codUsuCre = codUsuCre;
    }

    public Timestamp getFecUsuCre() { 
        return fecUsuCre; 
    }
    
    public void setFecUsuCre(Timestamp fecUsuCre) { 
        this.fecUsuCre = fecUsuCre;
    }

    public String getCodUsuMod() { 
        return codUsuMod; 
    }
    
    public void setCodUsuMod(String codUsuMod) { 
        this.codUsuMod = codUsuMod;
    }

    public Timestamp getFecUsuMod() { 
        return fecUsuMod; 
    }
    
    public void setFecUsuMod(Timestamp fecUsuMod) { 
        this.fecUsuMod = fecUsuMod;
    }
    
    // SETTER CLAVE: Para asignar el objeto Cliente 
    public Cliente getCliente() {
        return cliente;
    }
    
    public void setCliente(Cliente cliente) { 
        this.cliente = cliente; 
    } 

    public String getDesTipoCuenta() { 
        return desTipoCuenta; 
    }
    
    public void setDesTipoCuenta(String desTipoCuenta) { 
        this.desTipoCuenta = desTipoCuenta; 
    }

    public String getDesMoneda() { 
        return desMoneda; 
    }
    
    public void setDesMoneda(String desMoneda) { 
        this.desMoneda = desMoneda; 
    }

    public String getDesEstado() { 
        return desEstado; 
    }
    
    public void setDesEstado(String desEstado) { 
        this.desEstado = desEstado; 
    }
}