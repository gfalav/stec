class TasksController < ApplicationController
  
  # GET tasks en jerarquia - Informe de Avance
  def avance
    #inicializacion
    @res = Array.new
    
    #verif parametros
    if (params[:anio]==nil)
      anio = Time.new.year
    else
      anio = params[:anio]
    end
    fini = Date.new(anio,1,1)
    ffin = Date.new(anio,12,31)
    
    #ejecución recursiva
    avance_recursive(Account.find(1), @res, fini, ffin,'')

    #render :text => res
  end
  
  def avance_recursive(account, res, fini, ffin, namerad)
    namerad = namerad + '&nbsp;&nbsp;'
    
    if (account.children.count!=0)
      if (account.children[0].children.count!=0)
        res << Task.new.getavanceonlytask(account, fini, ffin, namerad)
      else
        res << Task.new.getavanceacum(account, fini, ffin, namerad)
      end
    else
      res << Task.new.getavance(account, fini, ffin, namerad)
    end
    
    account.children.each { |a|
      avance_recursive(a,res, fini, ffin, namerad)
    }
    
  end
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
