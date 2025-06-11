

    # Aplicar inline method ✅
    @property
    def estado_de_animo(self):
        ''' Regresa el estado de ánimo de nuestro zombie basado en el tiempo
            que ha pasado sin comer '''
        if datetime.now() - self.__ultimo_alimento > timedelta(seconds=self.AGRESIVO):
            estado = 'agresivo'
            return estado
        elif datetime.now() - self.__ultimo_alimento > timedelta(seconds=self.ENFADADO):
            return 'enfadado'
        elif datetime.now() - self.__ultimo_alimento > timedelta(seconds=self.NORMAL):
            return 'normal'
        else:
            return 'contento'
    
    # Aplicar extract variable ✅
    @property
    def peligrosidad(self):
        ''' Regresa el nivel de peligrosidad del zombie en tres niveles
            alta, media o baja '''
        
        zombie_feliz = (self.__tipo == TipoZombie.ZOMBIEINSTEIN or self.__tipo == TipoZombie.ZOMBIEPULTA) and (self.estado_de_animo == 'contento' or self.estado_de_animo == 'normal') and self.__cerebros_devorados >= 1
        zombie_buena_onda = not (self.__tipo == TipoZombie.ZOMBIEINSTEIN or self.__tipo == TipoZombie.ZOMBIEPULTA) and not (self.estado_de_animo == 'contento' or self.estado_de_animo == 'normal') and self.__cerebros_devorados >= 1
        
        if not zombie_feliz:
            return 'baja'
        elif not zombie_buena_onda:
            return 'media'
        else:
            return 'alta'


    # Aplicar replace temp with query ✅
    def ir(self, lugar, tiempo_del_recorrido: timedelta):
        ''' Regresa un mensaje con los detalles del recorrido, además de un valor
            boolean que indica si el zombie debería de ir a tal lugar basado en
            el tiempo de vida que le queda '''
        if self.tiempo_de_vida_restante >= tiempo_del_recorrido: # usar tiempo_de_vida_restante
            return f'Adelante, puede ir al {lugar}', True
        else:
            return f'No se recomienda ir al {lugar}. Desaparecerá antes', False
    
    # Aplicar Split temporary variable ✅
    def buscar_cerebros(self, radio: int):
        ''' Regresa los detalles asociados a la búsqueda de cerebros. El
            radio está en kilómetros'''
        perimetro = 2 * pi * radio
        area = pi * pow(radio, 2)
        return f'''Detalles de la búsqueda
        perímetro: {perimetro} km
        area     : {area} km
        '''
    
