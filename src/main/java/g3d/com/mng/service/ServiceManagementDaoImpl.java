package g3d.com.mng.service;

import java.util.List;

import javax.annotation.Resource;

import g3d.com.mng.ServiceSettingVO;

import org.springframework.stereotype.Repository;

@Repository("serviceManagementDao")
public class ServiceManagementDaoImpl implements ManagementDao
{
	
	@Resource(name="managementMapper")
	ManagementMapper managementMapper;
	
	public ServiceSettingVO getServiceSetting(int id)
	{
		return managementMapper.getServiceSetting(id);
	}
		
	public void saveServiceSetting(ServiceSettingVO vo)
	{
		Integer id = vo.getId();
		
		if(id == null)
		{
			// 1. 신규 저장
			managementMapper.insertServiceSetting(vo);

			if(vo.getId() != null)
			{
				updateServicedRastersByServiceId(vo.getId(), vo.getRasters(), vo.getRasterAlphas());
				updateServicedVectorsByServiceId(vo.getId(), vo.getVectors(), vo.getVectorAlphas());
			}
		}
		else
		{
			// 2. 기존 세팅 갱신
			managementMapper.updateServiceSetting(vo);
			updateServicedRastersByServiceId(vo.getId(), vo.getRasters(), vo.getRasterAlphas());
			updateServicedVectorsByServiceId(vo.getId(), vo.getVectors(), vo.getVectorAlphas());
		}
	}
	
	public void deleteServiceSetting(ServiceSettingVO vo)
	{
		managementMapper.deleteServiceSetting(vo.getId());
		managementMapper.deleteServicedRastersByServiceId(vo.getId());
		managementMapper.deleteServicedVectorsByServiceId(vo.getId());
	}

	protected void updateServicedRastersByServiceId(int serviceId, List<String> rasters, List<Double>rasterAlphas)
	{
		managementMapper.deleteServicedRastersByServiceId(serviceId);

		int rasterCount = rasters.size();
		for(int i = 0; i < rasterCount; i++)
			managementMapper.insertServicedRaster(rasters.get(i), serviceId, i, rasterAlphas.get(i));
	}
	
	protected void updateServicedVectorsByServiceId(int serviceId, List<String> vectors, List<Double> vectorAlphas)
	{
		managementMapper.deleteServicedVectorsByServiceId(serviceId);
		
		int vectorCount = vectors.size();
		for(int i = 0; i < vectorCount; i++)
			managementMapper.insertServicedVector(vectors.get(i), serviceId, i, vectorAlphas.get(i));
	}
}
