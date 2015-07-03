package http;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;

/**
 * 
 * @author luca
 */
public class Server 
{
	private boolean debug = false;
	private int port = 2004;
	private ServerSocket providerSocket = null;
	Connection conn = null;
	private int connection_id = 0;
	
	public Server(int connectionId) throws IOException 
	{
		providerSocket = new ServerSocket(port);
		if (debug) System.out.println("Opened the connection on "+providerSocket.getInetAddress().getHostAddress());
		this.connection_id  = connectionId;
	}

	public void run() 
	{
		if (providerSocket==null) 
			return;
		
		Socket connection = null;

		try 
		{			
			if (debug) System.out.println("waiting for request...");
			connection  = providerSocket.accept();		
			conn = new Connection(connection);
			conn.setId(connection_id);
			conn.readParams();
			
			if (debug) System.out.println("connection established");	
		} 
		catch (IOException ioException) 
		{
			if (debug) System.out.println("Error with connection");
			if (debug) ioException.printStackTrace();
		}
	}
	
	public HashMap<String,String> getParams()
	{
		return conn.getParam_table();
	}
	
	public Connection getConnection()
	{
		return conn;
	}

	public int getConnectionId() {
		return this.conn.getId();
	}

}
