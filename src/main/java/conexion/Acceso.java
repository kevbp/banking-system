package conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Acceso {

    private static final String URL = "jdbc:mysql://localhost:3306/BancoDB?useSSL=false&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection getConexion() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Conexión exitosa a la base de datos.");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Error: No se encontró el driver JDBC de MySQL.");
        } catch (SQLException e) {
            System.err.println("❌ Error SQL: " + e.getMessage());
        }
        return cn;
    }

    public static String ejecutar(String sql) {
        String msg = null;
        try {
            Connection cn = getConexion();
            if (cn == null) {
                msg = "No hay Conexion con la Base de Datos";
            } else {
                Statement st = cn.createStatement();
                st.executeUpdate(sql);
                cn.close();
            }
        } catch (SQLException e) {
            msg = e.getMessage();
        }
        return msg;
    }

    public static List listar(String sql) {
        System.out.println(sql);
        List lista = new ArrayList();
        try {
            Connection cn = getConexion();
            if (cn == null) {
                lista = null;
            } else {
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                ResultSetMetaData rm = rs.getMetaData();
                int numCol = rm.getColumnCount();
                while (rs.next()) {
                    Object[] fila = new Object[numCol];
                    for (int i = 0; i < numCol; i++) {
                        fila[i] = rs.getObject(i + 1);
                    }
                    lista.add(fila);
                }
                cn.close();
            }
        } catch (SQLException e) {
            lista = null;
        }
        return lista;
    }

    public static Object[] buscar(String sql) {
        Object[] fila = null;
        List lista = listar(sql);
        if (lista != null) {
            for (int i = 0; i < lista.size(); i++) {
                fila = (Object[]) lista.get(i);
            }
        }
        return fila;
    }

}
