<%@ page import="java.util.*, net.bookscape.model.Product, net.bookscape.model.Libro" language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>BookScape</title>
		<link rel="stylesheet" href="css/style.css">
		
		<style>
			div#contenuto{
				display: flex;
				flex-direction: row;
				flex-wrap: wrap;
				justify-content: center;
			}
			
			div#contenuto div.product{
				padding: 20px;
				width: 20%;
				border: 1px solid black;
				border-collapse: separate;
				box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
				margin: 15px;
				border-radius: 8px;
				box-sizing: border-box;
			}
			
			#logout {
	            position: absolute;
	            margin-left: 3%;
	            top: 130px;
	            margin-bottom: 20px;
	            font-size: 18px;
	        }
			
			.product img#productImage{
	            width: 160px;
	            height: 225px;
	            border-radius: 8px;
	        }
	       
		</style>
	</head>
	<body>
		<%@ include file="template/navbar.jsp" %>
		
		<%!String nomeTabella = "";%>
		
		<%
			String id = (String) session.getAttribute("cliente");
			if(id != null && !id.equals("")){
				%>
				<a id="logout" href="Logout">Logout</a>
				<%
			}
		%>
		
		<div id="contenuto">
		<%
			@SuppressWarnings("unchecked")
			Collection<Libro> libri = (Collection<Libro>)request.getAttribute("libri");
		
			if(libri == null || libri.isEmpty()) {
				response.sendRedirect("BookCatalog");
				return;
			} else {
				for(Libro l: libri) {
		%>
					<div class="product">
						<h2><%= l.getNome() %></h2>
						<p><%= l.getDescrizione() %></p>
						<p>Prezzo: <%= l.getPrezzo() %> EUR</p>
						<p>Quantità disponibile: <%= l.getQuantita() %></p>
						<a href="ProductDetails?productId=<%=l.getId()%>&type=<%=l.getClass().getSimpleName().toLowerCase()%>"><img id="productImage" src="<%=l.getImgURL()%>"></a>
						<form action="CartControl" method="post">
							<input type="hidden" name="productId" value="<%= l.getId() %>">
							<input type="hidden" name="type" value="<%=l.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="bookCatalog.jsp">
							<input type="submit" value="Aggiungi al carrello">
						</form>
						<hr>
						<form action="WishlistControl" method="post">
							<input type="hidden" name="productId" value="<%= l.getId() %>">
							<input type="hidden" name="type" value="<%=l.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="bookCatalog.jsp">
							<button class="bookmark" type=submit><img src="img/bookmark.png"></button>
						</form>
					</div>
		<%
				}
			}
		%>
		</div>
		
		<%@ include file="template/footer.html" %>
	</body>
</html>
