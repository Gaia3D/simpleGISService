package g3d.com.mng.service;

import egovframework.com.cmm.service.EgovProperties;
import g3d.com.mng.ServiceSettingVO;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("serviceSettingService")
public class ServiceManagementServiceImpl implements ManagementService
{

	@Resource(name="serviceManagementDao")
	ManagementDao managementDao;
	
	public ServiceSettingVO getNormalServiceSetting()
	{
		String strNormalServiceId = EgovProperties.getProperty("g3d.normalServiceId");
		
		if(strNormalServiceId == null || strNormalServiceId.isEmpty())
			return null;
		
		Integer normalServiceId = null;
		try
		{
			normalServiceId = Integer.valueOf(strNormalServiceId);
		}
		catch(Exception ex)
		{
			return null;
		}
		
		ServiceSettingVO vo = managementDao.getServiceSetting(normalServiceId);
		if(vo == null)
		{
			vo = new ServiceSettingVO();
			vo.setId(normalServiceId);
		}
		
		return vo;
	}
	
	public ServiceSettingVO getServiceSetting(int id)
	{
		return managementDao.getServiceSetting(id);
	}
	public void setServiceSetting(ServiceSettingVO vo)
	{
		if(vo == null)
			return;
		
		managementDao.saveServiceSetting(vo);
	}
	
	public void deleteServiceSetting(ServiceSettingVO vo)
	{
		managementDao.deleteServiceSetting(vo);
	}
}
