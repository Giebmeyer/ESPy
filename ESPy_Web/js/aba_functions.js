function JTabControl(divMaster,tabWidth,tabHeight)
{
	
	this.tabs = 0;
	this.addTab = addTab;
	this.id  = divMaster;
	
	Construtor(tabWidth,tabHeight);

	this.Container = getObj(divMaster+".ContainerDiv");
	this.Header = getObj(divMaster+".HeaderDiv");
	this.Body = getObj(divMaster+".BodyDiv");

	function Construtor(tabWidth,tabHeight)
	{
		var idContainer = divMaster+".ContainerDiv";
		var idHeader = divMaster+".HeaderDiv";
		var idBody = divMaster+".BodyDiv";

		this.Container = getObj(divMaster);
		this.Container.innerHTML =  "<div id='"+idContainer+"' class='jAbaContainer'></div>" + this.Container.innerHTML;
		this.Container = document.getElementById(idContainer);
		this.Container.innerHTML = "<div id='"+idHeader+"' Class='jAbaHeader'></div>" + "<div id='"+idBody+"' Class='jAbaBody'></div>"
		this.Header = getObj(idHeader);
		this.Body = getObj(idBody);
		
		this.Container.style.width = tabWidth;
		this.Container.style.height = tabHeight;
			
	}

	function addTab(divTab,TitleTab)
	{
		var htmlHeader = "";
		var htmlBody = "";
		var objDivOld = getObj(divTab);
		var bodyClass = "jTabBodyHidden";
		var headerClass = "jTabHeaderHidden";
		
		if(!TitleTab)
			TitleTab = divTab;
		if(this.tabs == 0)
			bodyClass = "jTabBodyInline";
		if(this.tabs == 0)
			headerClass = "jTabHeaderInline";
		
		htmlHeader = "<Span onClick='changeJTabControl(this.id)' id='"+this.id+".Header.Tab."+this.tabs+"' Class='"+headerClass+"'>"+TitleTab+"</Span>&nbsp;";
		htmlBody = " <Span id='"+this.id+".Body.Tab."+this.tabs+"' Class='"+bodyClass+"'>"+objDivOld.innerHTML+"</Tab>";
		objDivOld.innerHTML = "";
				
		Header.innerHTML = Header.innerHTML + htmlHeader;
		Body.innerHTML = Body.innerHTML + htmlBody;		
		
		this.tabs++;
	}
}

function changeJTabControl(Tab)
{
	var id = Tab.split(".");
	var i = 0;
	var j = 0;
	
	while(getObj(id[0]+".Header.Tab."+i))
	{
		getObj(id[0]+".Header.Tab."+i).className = "jTabHeaderHidden"
		i++;
	}
	getObj(Tab).className = "jTabHeaderInline";	

	i=0;
	while(getObj(id[0]+".Body.Tab."+j))
	{
		getObj(id[0]+".Body.Tab."+j).className = "jTabBodyHidden"
		j++;
	}
	getObj(id[0]+".Body.Tab."+id[3]).className = "jTabBodyInline";		
	
}
function getObj(idObj)	
{
	return document.getElementById(idObj);
}