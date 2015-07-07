package g3d.com.mng.service;

import g3d.com.mng.ServiceSettingVO;

public interface ManagementDao
{
	public ServiceSettingVO getServiceSetting(int id);
	public void saveServiceSetting(ServiceSettingVO vo);
	public void deleteServiceSetting(ServiceSettingVO vo);
}
