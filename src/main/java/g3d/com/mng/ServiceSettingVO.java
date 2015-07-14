package g3d.com.mng;

import java.util.ArrayList;
import java.util.List;

public class ServiceSettingVO
{
	Integer id;
	
	String url;
	
	String coordinateSystem;
	
	Double initialLon;
	
	Double initialLat;
	
	Double initialZoom;
	
	List<String> rasters = new ArrayList<String>();
	
	List<Double> rasterAlphas = new ArrayList<Double>();
	
	List<String> vectors = new ArrayList<String>();
	
	List<Double> vectorAlphas = new ArrayList<Double>();
	
//	List<String> rastersToBeRemoved = new  ArrayList<String>();
//	
//	List<String> vectorsToBeRemoved = new  ArrayList<String>();
//	
//	List<String> rastersToBeAdded = new  ArrayList<String>();
//	
//	List<String> vectorsToBeAdded = new  ArrayList<String>();
	
	public Integer getId()
	{
		return this.id;
	}
	
	public void setId(Integer id)
	{
		this.id = id;
	}
	
	public String getUrl()
	{
		return this.url;
	}
	
	public void setUrl(String url)
	{
		this.url = url;
	}
	
	public String getCoordinateSystem()
	{
		return this.coordinateSystem;
	}
	
	public void setCoordinateSystem(String coordinateSystem)
	{
		this.coordinateSystem = coordinateSystem;
	}
	
	public Double getInitialLon()
	{
		return this.initialLon;
	}
	
	public void setInitialLon(Double initialLon)
	{
		this.initialLon = initialLon;
	}
	
	public Double getInitialLat()
	{
		return this.initialLat;
	}
	
	public void setInitialLat(Double initialLat)
	{
		this.initialLat = initialLat;
	}
	
	public Double getInitialZoom()
	{
		return this.initialZoom;
	}
	
	public void setInitialZoom(Double initialZoom)
	{
		this.initialZoom = initialZoom;
	}
	
	public List<String> getRasters()
	{
		return this.rasters;
	}
	
	public void setRasters(List<String> rasters)
	{
		this.rasters = rasters;
	}
	
	public List<Double> getRasterAlphas()
	{
		return this.rasterAlphas;
	}
	
	public void setRasterAlphas(List<Double> rasterAlphas)
	{
		this.rasterAlphas = rasterAlphas;
	}
	
	public List<String> getVectors()
	{
		return this.vectors;
	}
	
	public void setVectors(List<String> vectors)
	{
		this.vectors = vectors;
	}
	
	public List<Double> getVectorAlphas()
	{
		return this.vectorAlphas;
	}
	
	public void setVectorAlphas(List<Double> vectorAlphas)
	{
		this.vectorAlphas = vectorAlphas;
	}
	
//	public List<String> getRastersToBeRemoved()
//	{
//		return this.rastersToBeRemoved;
//	}
//	
//	public void setRastersToBeRemoved(List<String> toBeRemoved)
//	{
//		this.rastersToBeRemoved = toBeRemoved;
//	}
//	
//	public List<String> getVectorsToBeRemoved()
//	{
//		return this.vectorsToBeRemoved;
//	}
//	
//	public void setVectorsToBeRemoved(List<String> toBeRemoved)
//	{
//		this.vectorsToBeRemoved = toBeRemoved;
//	}
//	
//	public List<String> getRastersToBeAdded()
//	{
//		return this.rastersToBeAdded;
//	}
//	
//	public void setRastersToBeAdded(List<String> toBeAdded)
//	{
//		this.rastersToBeAdded = toBeAdded;
//	}
//	
//	public List<String> getVectorsToBeAdded()
//	{
//		return this.vectorsToBeAdded;
//	}
//	
//	public void setVectorsToBeAdded(List<String> toBeAdded)
//	{
//		this.vectorsToBeAdded = toBeAdded;
//	}
	
	public boolean addRaster(String rasterName)
	{
		return this.rasters.add(rasterName);
	}
	
	public boolean removeRaster(String rasterName)
	{
		return this.rasters.remove(rasterName);
	}
	
	public boolean addVector(String vectorName)
	{
		return this.vectors.add(vectorName);
	}
	
	public boolean removeVector(String vectorName)
	{
		return this.vectors.remove(vectorName);
	}
	
//	public boolean addRasterToBeRemoved(String rasterName)
//	{
//		return this.rastersToBeRemoved.add(rasterName);
//	}
//	
//	public boolean removeRasterToBeRermoved(String rasterName)
//	{
//		return this.rastersToBeRemoved.remove(rasterName);
//	}
//	
//	public boolean addVectorToBeRemoved(String vectorName)
//	{
//		return this.vectorsToBeRemoved.add(vectorName);
//	}
//	
//	public boolean removeVectorToBeRemoved(String vectorName)
//	{
//		return this.vectorsToBeRemoved.remove(vectorName);
//	}
//	
//	public boolean addRasterToBeAdded(String rasterName)
//	{
//		return this.rastersToBeAdded.add(rasterName);
//	}
//	
//	public boolean removeRasterToBeAdded(String rasterName)
//	{
//		return this.rastersToBeAdded.remove(rasterName);
//	}
//	
//	public boolean addVectorToBeAdded(String vectorName)
//	{
//		return this.vectorsToBeAdded.add(vectorName);
//	}
//	
//	public boolean removeVectorToBeAdded(String vectorName)
//	{
//		return this.vectorsToBeAdded.remove(vectorName);
//	}
}


