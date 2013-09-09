package net.viralpatel.contact.controller;
 
import importer.TestImporter;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.classic.Session;

import net.viralpatel.contact.model.Contact;
import net.viralpatel.contact.util.HibernateUtil;
 
public class ContactManager extends HibernateUtil {
 
    public Contact add(Contact contact) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.save(contact);
        session.getTransaction().commit();
        return contact;
    }
    
    public boolean createFile(String s){
    	if (s != null ){
          File f = new File(s);
          if (f.exists()){
        	  return false;
          }
          else{
            try{
              f.createNewFile();
              System.out.println( "create new file " + s );
              return true;
            } catch(IOException e){ 
            	e.printStackTrace();
            	return false;
            }
          }
        }
    	return false;
    }
    
    
    public String start(Contact c){	
    	// Tranformator scheiben in c:\arbeit\temp --> Datei-Handling
    	String filename = "C:\\Arbeit\\temp\\" + c.getFirstName();
    	if(this.createFile(filename)){
    		try {
    	      BufferedWriter out = new BufferedWriter(
    	                           new OutputStreamWriter(
    	                           new FileOutputStream(filename)));
    	      
    	      //for( int i=0; i<vec.size(); i++ ){
    	      //testausgabe= vec.get(i).toString();
    	      out.write(c.getMapper(), 0, c.getMapper().length());
    	      //out.newLine();
    	      
    	      out.close();
    	    } 
    	    catch( IOException ex ) {
    	      System.out.println( ex );
    	    }
    	}
    	
    	//Parameter schreiben:
    	
    	TestImporter importer = new TestImporter();
    	//importer.SOURCE_URL = 
    	
    	// start
    	try {
			importer.beforeTest();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	importer.importDataGovUk();
    	
    	// Logging????
    	
    	
    	return null;
    }
    
    public Contact delete(Long id) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Contact contact = (Contact) session.load(Contact.class, id);
        if(null != contact) {
            session.delete(contact);
        }
        session.getTransaction().commit();
        return contact;
    }
 
    public List<Contact> list() {
         
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List<Contact> contacts = null;
        try {
             
            contacts = (List<Contact>)session.createQuery("from Contact").list();
             
        } catch (HibernateException e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
        session.getTransaction().commit();
        return contacts;
    }
}