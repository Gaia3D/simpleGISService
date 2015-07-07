package g3d.com.mng.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import g3d.com.mng.ServiceSettingVO;

@Mapper("managementMapper")
public interface ManagementMapper
{
	public ServiceSettingVO getServiceSetting(int id); 
	public void insertServiceSetting(ServiceSettingVO vo);
	public void updateServiceSetting(ServiceSettingVO vo);
	public void deleteServiceSetting(int id);

	public ArrayList<String> getServicedRasters(int serviceId);
	public ArrayList<String> getServicedVectors(int serviceId);
	
	public void insertServicedRaster(@Param("raster") String raster, @Param("serviceId") int serviceId, @Param("zOrder") int zOrder);
	public void insertServicedVector(@Param("vector") String vector, @Param("serviceId") int serviceId, @Param("zOrder") int zOrder);
	
	public void deleteServicedRastersByServiceId(int serviceId);
	public void deleteServicedRasterByZOrder(@Param("serviceId") int serviceId, @Param("zOrder") int zOrder);
	
	public void deleteServicedVectorsByServiceId(int serviceId);
	public void deleteServicedVectorByZOrder(@Param("serviceId") int serviceId, @Param("zOrder") int zOrder);
}
