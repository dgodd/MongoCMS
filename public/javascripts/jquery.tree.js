function parseTree(ul){
    var tags = [];
    ul.children("li").each(function(){
        var subtree =    $(this).children("ul");
        if(subtree.size() > 0)
            tags.push([$(this).attr("id"), parseTree(subtree)]);
        else
            tags.push($(this).attr("id"));
    });
    return tags;
}
 
$(document).ready(function(){
        
    var treeSortDrop = {
	scope: 'treesort',
        tolerance        : "pointer",
        hoverClass        : "tree_hover",
	greedy: true,
	hoverClass: 'drophover',
        drop            : function(event, ui){
		var dropped = ui.draggable;
		dropped.css({top: 0, left: 0});
		var me = $(this);
		if(me == dropped)
			return;
		var oldParent = dropped.parent();
		var branch = false;
		if(me.hasClass('extra')) {
			branch = me.parents('ul:first');
			me.after(dropped);
		} else {
			branch = me.children("ul");
			if(branch.size() == 0) {
				branch = $('<ul>');
				branch.attr('rel', me.attr('rel'));
				me.append(branch);
			}
            		branch.eq(0).append(dropped);
		}
		var oldBranches = $("li", oldParent);
		if (oldBranches.size() == 0) { $(oldParent).remove(); }
		if(branch) {
			var hash = { 'parent':branch.attr('rel'), 'order':branch.children('li').map(function() { return $(this).attr('rel') }) };
			$.post('/pages/positions', hash);
		}
	}
    };
    
    $("ul.treesort li:not(.extra)").droppable(treeSortDrop);
    $("ul.treesort li:not(.extra)").draggable({
	scope: 'treesort',
        opacity: 0.5,
        revert: true,
	start: function(event,ui) {
		$('ul.treesort').addClass('dragging');
		$("ul.treesort li:not(.extra)").before('<li class="extra"><!-- --></li>');
		$("ul.treesort li.extra").droppable(treeSortDrop);
	},
	stop: function(event,ui) {
		$('ul.treesort li.extra').remove();
		$('ul.treesort').removeClass('dragging');
	}
    });

    
    $("#save").click(function(){
        /*
        var tree = $.toJSON(parseTree($("#tag_tree")));
        $.post("@saveTags", {tags: tree}, function(res){
            $("#printOut").html(res);
        });
        */
        $.debug.print_r(parseTree($("#tag_tree")), "printOut", false);
    });
});
