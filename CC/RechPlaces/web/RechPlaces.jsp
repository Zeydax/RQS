<%-- 
    Document   : RechPlaces
    Created on : 23-nov.-2017, 11:37:12
    Author     : Philippe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="Panier" scope="session" class="Beans.Panier"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>RQS - Recherche de places libres</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/RechPlaces.css">
    </head>
    <body>
        <nav class="navbar sticky-top navbar-dark bg-dark justify-content-between">
            <a class="navbar-brand" href="RechPlaces.jsp"><i class="fa fa-film"></i><strong> Rennequinepolis</strong></a>
            <%  if(session.getAttribute("isConnected") != null) { %>
                <button type="button" class ="btn btn-success ml-1"> 
                    <a id="redirection" href="Servlet?action=AfficherPanier">0
                        <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                        Panier
                    </a>
                </button>
            <% } else { %>
                <button type="button" class ="btn btn-success ml-1" data-toggle="modal" data-target="#ModalConnexion"> 
                    <i class="fa fa-power-off" aria-hidden="true"></i>
                    Se connecter pour voir le panier
                </button>
            <% } %>
        </nav>
        
        <div class="container" id="main"> 
            <div class="col-md-12 mt-5"></div>
            
                <h2 class="display-4 text-center">Recherche de places disponibles</h2>
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title text-center">Critères de recherche</h2>
                        <form class="form-inline" id="searchForm" action="Servlet" method="GET">
                            <div class="row mx-auto">
                                <div class="col">
                                    <label for="complexeInput">Complexe</label>
                                    <select name="complexeInput" id="complexeInput" type="text" class="form-control" placeholder="First name">
                                        <option value="CC1">CC1</option>
                                        <option value="CC2">CC2</option>
                                        <option value="CC3">CC3</option>
                                        <option value="CC4">CC4</option>
                                        <option value="CC5">CC5</option>
                                        <option value="CC6">CC6</option>
                                    </select>
                                </div>
                                <div class="col" id="divPopSel">
                                    <label for="populariteSelect">La popularité des films</label>
                                    <select name="populariteSelect" id="populariteSelect" type="text" class="form-control" placeholder="Inf" style="width: 165px;">
                                        <option value="Default">Par défaut</option>
                                        <option value="Inf">Inférieure à</option>
                                        <option value="Sup">Supérieure à</option>
                                        <option value="Egale">Égale à</option>
                                    </select>
                                </div>
                                <div class="col" id="divPerSel">
                                    <label for="perenniteSelect">La pérennité des films</label>
                                    <select name="perenniteSelect" id="perenniteSelect" type="text" class="form-control" placeholder="Inf" style="width: 165px;">
                                        <option value="Default">Par défaut</option>
                                        <option value="Inf">Inférieure à</option>
                                        <option value="Sup">Supérieure à</option>
                                        <option value="Egale">Égale à</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row mx-auto">
                                <div class="col">   
                                    <label for="acteursInput">Le(s) acteur(s)</label>
                                    <input type="text" name="acteursInput" id="acteursInput" class="form-control">
                                </div>
                                <div class="col">   
                                    <label for="realisateursInput">Le(s) réalisateur(s)</label>
                                    <input type="text" name="realisateursInput" id="realisateursInput" class="form-control">
                                </div>
                                <div class="col">   
                                    <label for="genresInput">Le(s) genre(s)</label>
                                    <input type="text" name="genresInput" id="genresInput" class="form-control">
                                </div>
                                <div class="col">   
                                    <label for="titreInput">Le titre ou une partie du titre</label>
                                    <input type="text" name="titreInput" id="titreInput" class="form-control" style="width: 300px;">
                                </div>
                            </div>
                            <input id="inputHidden" type="hidden" name="action" value="Recherche">
                            <div class="row mx-auto mt-4">                                
                                <div class="col">
                                    <button class="btn btn-lg btn-success" type="submit" id="submit"><i class="fa fa-search"></i> Rechercher</button>
                                </div>                                
                            </div>
                        </form>
                    </div>
                </div>
            </div>  
        </div>
        <div>
        <div class="container" id="main"> 
            <div class="col-md-12 mt-5"></div>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title text-center">Résultats de la recherche</h5>
                    <table class ="table table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col" class="text-center">Poster du film</th>
                                <th scope="col" class="text-center">Titre du film</th>
                                <th scope="col" class="text-center">Popularité</th>
                                <th scope="col" class="text-center">Pérennité</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th id="poster" scope="row">
                                    <img class="rounded float-left" alt="No free image man (en)" src="https://image.tmdb.org/t/p/w45/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"/>
                                </th>
                                <td class="align-middle text-center">
                                    <a href="Servlet?action=FicheFilm&IdFilm=1">Mad Max Fury Road</a>
                                </td>
                                <td class="align-middle text-center">145</td>
                                <td class="align-middle text-center">14</td>
                                <td class="align-middle text-center">
                                    <button type="button" class="btn btn-danger ml-1">
                                        <a id="redirection" href="Servlet?action=AfficherSeancesFilm&IdFilm=1001">
                                            <i class="fa fa-ticket" aria-hidden="true"></i>
                                            Afficher les séances pour ce film 
                                        </a>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
            
        <jsp:include page="ModalConnexion.jsp"></jsp:include>    
            
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>    
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/RechPlaces.js"></script>
    </body>
</html>
