package g3d.com.mng.service;

import g3d.com.mng.ServiceSettingVO;

public interface ManagementService
{
	public ServiceSettingVO getNormalServiceSetting();
	
	public ServiceSettingVO getServiceSetting(int id);
	
	public void setServiceSetting(ServiceSettingVO vo);
	
	public void deleteServiceSetting(ServiceSettingVO vo);
}
