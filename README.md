
 <% @client.each do |p|%>
        <option value="<%=p.id%>"><%=p.name%></option>
  <%end%>