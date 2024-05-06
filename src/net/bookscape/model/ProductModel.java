package net.bookscape.model;

import java.sql.SQLException;
import java.util.Collection;

public interface ProductModel <T> {
	
	public void doSave(T product) throws SQLException;

	public boolean doDelete(int id) throws SQLException;

	public T doRetrieveByKey(int id) throws SQLException;
	
	public Collection<T> doRetrieveAll(String order) throws SQLException;
}
