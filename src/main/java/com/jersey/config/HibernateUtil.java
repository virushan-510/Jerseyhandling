package com.jersey.config;
import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import com.jersey.models.Employee;

// import net.javaguides.usermanagement.model.User;

public class HibernateUtil {
    private static SessionFactory sessionFactory;
    private static ApplicationProperties applicationProperties;
    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                applicationProperties = ApplicationProperties.getInstance();
                Configuration configuration = new Configuration();

                // Hibernate settings equivalent to hibernate.cfg.xml's properties use mariadb
                Properties settings = new Properties();

                settings.put(Environment.DRIVER, applicationProperties.get("sql.connection.driver"));
                settings.put(Environment.URL, applicationProperties.get("sql.connection.url"));
                settings.put(Environment.USER, applicationProperties.get("sql.connection.username"));
                settings.put(Environment.PASS, applicationProperties.get("sql.connection.password"));
                settings.put(Environment.DIALECT, applicationProperties.get("hibernate.dialect"));
                settings.put(Environment.SHOW_SQL, applicationProperties.get("hibernate.show_sql"));
                settings.put(Environment.HBM2DDL_AUTO, applicationProperties.get("hibernate.ddl-auto"));
                settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, applicationProperties.get("hibernate.current_session_context_class"));

                configuration.setProperties(settings);
                configuration.addAnnotatedClass(Employee.class);

                ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                    .applySettings(configuration.getProperties()).build();
                System.out.println("Hibernate Java Config serviceRegistry created");
                sessionFactory = configuration.buildSessionFactory(serviceRegistry);
                return sessionFactory;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return sessionFactory;
    }
}