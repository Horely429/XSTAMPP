package xstampp.astpa.controlstructure;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import xstampp.astpa.model.controlstructure.interfaces.IRectangleComponent;
import xstampp.astpa.model.interfaces.IControlStructureEditorDataModel;
import xstampp.model.IDataModel;
import xstampp.ui.common.ProjectManager;
import xstampp.ui.navigation.api.IDynamicStepsProvider;

public class ControlStructureProvider implements IDynamicStepsProvider {

  @Override
  public List<DynamicDescriptor> getStepMap(UUID projectId) {
    List<DynamicDescriptor> list = new ArrayList<>();
    IDataModel dataModel = ProjectManager.getContainerInstance().getDataModel(projectId);
    if(dataModel != null) {
      for(IRectangleComponent root : ((IControlStructureEditorDataModel)dataModel).getRoots()) {
        Map<String, Object> properties = new HashMap<>();
        properties.put("ROOT", root.getId());
        list.add(new DynamicDescriptor(root.getText(), properties));
      }
    }
    return list;
  }

}
