package g3d.com.mng.web;

import javax.annotation.Resource;

import egovframework.com.cmm.service.EgovProperties;
import g3d.com.mng.ServiceSettingVO;
import g3d.com.mng.service.ManagementService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.ModelMap;

@Controller
public class ServiceManagementController {
	
	@Resource(name = "serviceSettingService")
	private ManagementService managementService;
	
	@RequestMapping(value="/g3d/normalServiceSettings.do")
	public String getNormalServiceSettings(ModelMap model)
	{	
		ServiceSettingVO vo = managementService.getNormalServiceSetting();
	
		if(vo == null)
		{
			// GIS service 용 에러 페이지 만들어야 함. 에러 내용도 보여줘야 함 - khj 20150706
			// 지금은 404 뜸
			return "forward:/g3d/error.do";
		}

		model.addAttribute("serviceSetting", vo);
		
		return "g3d/gisServiceSetting";
	}

	@RequestMapping(value="/g3d/setNormalServiceSettings.do")
	public String setNormalServiceSettings(@ModelAttribute("serviceSettingVO") ServiceSettingVO serviceSettingVO, ModelMap modelMap)
	{
		System.out.println("save settings requested");
		return "redirect:/uat/uia/actionMain.do";
	}
}
